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
├── scripts/
│   ├── setup.sh              # Instalação WordPress + Tainacan
│   └── criar-colecao-exemplo.sh  # Cria coleção demo (não usado)
└── wiki/                     # Tutoriais para Wiki do GitHub
    ├── Home.md               # Página inicial da Wiki (índice)
    ├── Instalando-o-Ambiente.md      # Guia completo (instalação + distribuição)
    └── Primeiros-Passos-no-Tainacan.md  # Tutorial uso do Tainacan
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
docker exec tainacan-wordpress bash /usr/local/bin/setup-tainacan.sh

# Parar ambiente
docker-compose down

# Reiniciar do zero (apaga dados)
docker-compose down -v
docker-compose up -d
docker exec tainacan-wordpress bash /usr/local/bin/setup-tainacan.sh

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

## Repositório Git

O projeto está versionado com Git e hospedado no GitHub.

**Configuração local:**
- Usuário: Najla Melo
- Email: najlamelo@gmail.com
- Branch principal: main

**Comandos Git:**
```powershell
# Ver status
git status

# Adicionar e commitar
git add .
git commit -m "Descrição das mudanças"

# Enviar para GitHub
git push origin main

# Baixar atualizações
git pull origin main
```

## Tutoriais Criados (Wiki)

A pasta `wiki/` contém tutoriais para a Wiki do GitHub (3 páginas):

### 1. Home.md
- Página inicial com índice dos tutoriais
- Links para as duas páginas de tutorial
- Tabela de acesso rápido com URLs e credenciais
- Comandos úteis

### 2. Instalando-o-Ambiente.md (Guia Completo)
- **Como compartilhar o projeto** (ZIP ou GitHub)
- **Verificação de pré-requisitos:**
  - WSL 2 (instalação e verificação)
  - Virtualização na BIOS
  - Recursos do Windows
  - Git (instalação opcional)
- **Instalação do Docker Desktop**
- **3 opções para obter os arquivos:** ZIP, GitHub+Git, GitHub sem Git
- **Uso do terminal do Docker Desktop** (não Prompt de Comando)
- Comandos com sintaxe Unix (`/c/projetos/` em vez de `C:\`)
- **Problemas comuns e soluções:**
  - Git não reconhecido
  - WSL não instalado
  - Virtualização desabilitada
  - WSL integration stopped
  - Docker failed to start
  - Porta em uso

### 3. Primeiros-Passos-no-Tainacan.md
- O que é o Tainacan e quem usa
- Conceitos: Coleções, Itens, Metadados, Taxonomias, Filtros
- Passo a passo para criar coleção
- Como adicionar metadados e itens
- Como criar filtros e publicar

**Para publicar na Wiki do GitHub:**
1. No repositório, vá em Settings → Features → Wiki (habilitar)
2. Crie páginas: Home, Instalando-o-Ambiente, Primeiros-Passos-no-Tainacan
3. Cole o conteúdo de cada arquivo

## Distribuição do Projeto

O projeto pode ser distribuído de duas formas principais:
1. **Arquivo ZIP:** Compactar pasta e enviar (email, Drive, pendrive)
2. **GitHub:** Compartilhar link: https://github.com/najlamelo/tainacan-aprendizado

**Para distribuir:**
1. Enviar ZIP ou link do GitHub
2. O usuário final segue o guia `wiki/Instalando-o-Ambiente.md`
3. Todos os comandos são executados no terminal do Docker Desktop

## Possíveis Melhorias Futuras

1. Adicionar backup automático dos dados
2. Criar script para importar/exportar coleções
3. Adicionar mais coleções de exemplo pré-configuradas
4. Configurar HTTPS com certificado autoassinado
5. Adicionar Portainer para gerenciamento visual dos containers
6. Criar versão com shell script para Linux/macOS
7. Adicionar imagens/screenshots aos tutoriais da Wiki
8. Criar vídeos tutoriais complementares
9. Traduzir tutoriais para inglês/espanhol

## Histórico de Sessões

### Sessão 1 (Janeiro 2026)
- Criação inicial do ambiente Docker
- Configuração do WordPress + Tainacan
- Resolução de problemas de conexão MySQL/MariaDB
- Criação de coleção de exemplo "Acervo de Demonstração"

### Sessão 2 (17 Janeiro 2026)
- Inicialização do repositório Git
- Configuração do GitHub (usuário: najlamelo@gmail.com)
- Criação inicial de 4 tutoriais para Wiki
- **Versão v1.0.0** - Versão inicial com tutoriais

- Adição de verificação de pré-requisitos (WSL, virtualização)
- **Versão v1.1.0** - Guia com pré-requisitos

- Solução para erro "WSL integration stopped"
- **Versão v1.1.1** - Solução WSL integration

- Instruções de instalação do Git
- **Versão v1.1.2** - Instruções Git

- Mesclagem dos tutoriais (Distribuindo + Instalando → único arquivo)
- Remoção de Distribuindo-o-Ambiente.md
- **Versão v1.2.0** - Tutoriais mesclados

### Sessão 3 (17 Janeiro 2026 - continuação)
Resolução de problemas de execução do script setup em máquinas Windows de destino.

**Problema:** Erro `exec /usr/local/bin/setup-tainacan.sh: no such file or directory`
**Causa:** Terminações de linha Windows (CRLF) em scripts shell não funcionam em Linux.

**Soluções aplicadas:**

1. **v1.2.1** - Adicionado `.gitattributes` para forçar LF em arquivos .sh
   - Não resolveu para repositórios já clonados

2. **v1.2.2** - Comando de setup alterado para usar bash explicitamente
   - De: `docker exec container setup-tainacan.sh`
   - Para: `docker exec container bash /usr/local/bin/setup-tainacan.sh`
   - Arquivos atualizados: instalar.bat, README.md, CLAUDE.md, wiki/*.md

3. **v1.2.3** - Conversão CRLF→LF adicionada ao Dockerfile (solução definitiva)
   - Linha adicionada: `RUN sed -i 's/\r$//' /usr/local/bin/setup-tainacan.sh`
   - Garante funcionamento independente das configurações Git do usuário

**Versão atual:** v1.2.3

**Estrutura final da Wiki:**
- Home (índice)
- Instalando-o-Ambiente (guia completo)
- Primeiros-Passos-no-Tainacan (tutorial Tainacan)

## Lições Aprendidas

### Problema de Line Endings (CRLF vs LF)
Scripts shell (.sh) devem ter terminações LF para funcionar em Linux. Quando desenvolvido em Windows:

1. **Prevenção:** Usar `.gitattributes` com `*.sh text eol=lf`
2. **Correção no build:** Adicionar `sed -i 's/\r$//'` no Dockerfile
3. **Execução:** Usar `bash /path/script.sh` em vez de apenas `/path/script.sh`

### Comando docker exec em Windows
O comando `docker exec container script.sh` pode falhar em Windows. Usar sempre:
```
docker exec container bash /full/path/to/script.sh
```

## Referências

- [Tainacan Wiki](https://wiki.tainacan.org)
- [Tainacan GitHub](https://github.com/tainacan/tainacan)
- [WordPress Docker](https://hub.docker.com/_/wordpress)
- [WP-CLI Commands](https://developer.wordpress.org/cli/commands/)
- [Docker Compose Docs](https://docs.docker.com/compose/)
