# CLAUDE.md - Contexto do Projeto

Este arquivo documenta o contexto e decisões tomadas neste projeto para referência em sessões futuras.

## Visão Geral

**Projeto:** Ambiente Docker para Aprendizado do Tainacan
**Objetivo:** Criar um ambiente completo e autocontido onde museólogos possam aprender a usar o Tainacan sem necessidade de configuração manual de servidores.
**Data de criação:** Janeiro de 2026

## O que é o Tainacan

Tainacan é um software livre brasileiro para gestão de acervos digitais, desenvolvido como plugin para WordPress. É usado por museus, bibliotecas, arquivos e instituições culturais para organizar, preservar e disponibilizar coleções online.

- Site oficial: https://tainacan.org
- Repositório: https://github.com/tainacan/tainacan
- Wiki: https://wiki.tainacan.org

## Arquitetura do Ambiente

```
┌─────────────────────────────────────────────────────────┐
│                    Docker Network                        │
│                   (tainacan-network)                     │
│                                                          │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │   MariaDB    │  │  WordPress   │  │  phpMyAdmin  │  │
│  │   (db)       │  │  + Tainacan  │  │              │  │
│  │              │  │  + WP-CLI    │  │              │  │
│  │  Port: 3306  │  │  Port: 8080  │  │  Port: 8081  │  │
│  └──────────────┘  └──────────────┘  └──────────────┘  │
│         │                  │                  │         │
│         └────────┬─────────┴─────────┬───────┘         │
│                  │                   │                  │
│           ┌──────┴──────┐    ┌──────┴──────┐          │
│           │  db_data    │    │ wordpress   │          │
│           │  (volume)   │    │   _data     │          │
│           └─────────────┘    └─────────────┘          │
└─────────────────────────────────────────────────────────┘
```

## Estrutura de Arquivos

```
C:\projetos\tainacan-aprendizado\
├── CLAUDE.md                 # Este arquivo (contexto para IA)
├── README.md                 # Documentação para usuários
├── docker-compose.yml        # Orquestração dos containers
├── Dockerfile                # Imagem customizada WordPress
├── instalar.bat              # Script de instalação Windows
├── .gitignore                # Arquivos ignorados pelo Git
├── config/
│   └── uploads.ini           # Configurações PHP (upload 100MB)
└── scripts/
    ├── setup.sh              # Instalação WordPress + Tainacan
    └── criar-colecao-exemplo.sh  # Cria coleção demo (não usado)
```

## Decisões Técnicas e Problemas Resolvidos

### 1. MySQL 8.0 → MariaDB 10.11
**Problema:** MySQL 8.0 exige TLS/SSL por padrão, causando erros de conexão com WP-CLI.
**Solução:** Trocamos para MariaDB 10.11 que é compatível com MySQL e não tem esse problema.

### 2. WP-CLI como Container Separado → WP-CLI Embutido
**Problema:** Container wordpress:cli separado tinha problemas de SSL ao conectar ao banco.
**Solução:** Instalamos WP-CLI diretamente no Dockerfile do WordPress, evitando problemas de conexão.

### 3. Variáveis Shell no docker-compose.yml
**Problema:** Variáveis como `$TRIES` eram interpretadas pelo docker-compose.
**Solução:** Escapar com `$$` (ex: `$$TRIES`) para serem interpretadas pelo shell dentro do container.

### 4. ImageMagick já instalado
**Problema:** `pecl install imagick` falhava porque já estava instalado na imagem base.
**Solução:** Usar `|| true` para ignorar erro se já instalado.

### 5. Atributo `version` obsoleto
**Problema:** Docker Compose moderno não usa mais `version: '3.8'`.
**Solução:** Removemos a linha `version`.

## Componentes e Configurações

### docker-compose.yml
- **db:** MariaDB 10.11 com healthcheck
- **wordpress:** Imagem customizada (Dockerfile) na porta 8080
- **phpmyadmin:** Interface web para banco na porta 8081
- Volumes nomeados para persistência de dados

### Dockerfile
- Base: `wordpress:php8.2-apache`
- Extensões PHP: gd, zip, exif, opcache, imagick
- WP-CLI instalado em `/usr/local/bin/wp`
- Script setup copiado para `/usr/local/bin/setup-tainacan.sh`
- Política ImageMagick ajustada para permitir PDFs

### scripts/setup.sh
- Aguarda wp-config.php existir
- Instala WordPress em pt_BR com retry automático
- Configura timezone America/Sao_Paulo
- Instala e ativa plugin Tainacan
- Configura permalinks bonitos
- Remove plugins/temas desnecessários

### config/uploads.ini
- upload_max_filesize = 100M
- post_max_size = 100M
- memory_limit = 512M
- max_execution_time = 300

## Credenciais Padrão

| Serviço | Usuário | Senha |
|---------|---------|-------|
| WordPress | admin | tainacan123 |
| MariaDB | wordpress | wordpress |
| MariaDB root | root | rootpassword |
| phpMyAdmin | wordpress | wordpress |

## Comandos de Referência

```powershell
# Iniciar ambiente
docker-compose up -d

# Setup inicial (primeira vez)
docker exec tainacan-wordpress setup-tainacan.sh

# Parar ambiente
docker-compose down

# Reiniciar do zero (apaga dados)
docker-compose down -v
docker-compose up -d
docker exec tainacan-wordpress setup-tainacan.sh

# Ver logs
docker-compose logs -f wordpress

# Executar WP-CLI
docker exec tainacan-wordpress wp [comando] --allow-root

# Acessar shell do container
docker exec -it tainacan-wordpress bash
```

## API do Tainacan via WP-CLI

O Tainacan expõe suas entidades via PHP. Exemplo de criação de coleção:

```php
$collection = new \Tainacan\Entities\Collection();
$collection->set_name("Nome da Coleção");
$collection->set_description("Descrição");
$collection->set_status("publish");

$repo = \Tainacan\Repositories\Collections::get_instance();
if ($collection->validate()) {
    $collection = $repo->insert($collection);
}
```

**Importante:** Sempre chamar `validate()` antes de `insert()`.

## Coleção de Exemplo Criada

Durante a sessão, foi criada uma coleção "Acervo de Demonstração" com:
- 5 metadados: Autor/Artista, Data de Criação, Técnica, Dimensões, Localização
- 5 itens de exemplo: Vaso Marajoara, Máscara Kayapó, Tear Nordestino, Berimbau, Carranca

## URLs de Acesso

| Recurso | URL |
|---------|-----|
| Site | http://localhost:8080 |
| Admin WordPress | http://localhost:8080/wp-admin |
| Painel Tainacan | http://localhost:8080/wp-admin/admin.php?page=tainacan_admin |
| phpMyAdmin | http://localhost:8081 |

## Distribuição do Projeto

O projeto pode ser distribuído de três formas:
1. **Cópia direta:** Zipando a pasta e enviando
2. **GitHub:** Clonando o repositório
3. **Imagem Docker:** Exportando com `docker save`

O arquivo `instalar.bat` automatiza a instalação no Windows.

## Possíveis Melhorias Futuras

1. Adicionar backup automático dos dados
2. Criar script para importar/exportar coleções
3. Adicionar mais coleções de exemplo
4. Configurar HTTPS com certificado autoassinado
5. Adicionar Portainer para gerenciamento visual dos containers
6. Criar versão com docker-compose para Linux/macOS (shell script)

## Referências

- [Tainacan Wiki](https://wiki.tainacan.org)
- [Tainacan GitHub](https://github.com/tainacan/tainacan)
- [WordPress Docker](https://hub.docker.com/_/wordpress)
- [WP-CLI Commands](https://developer.wordpress.org/cli/commands/)
- [Docker Compose Docs](https://docs.docker.com/compose/)
