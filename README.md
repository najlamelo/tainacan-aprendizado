# Tainacan - Ambiente de Aprendizado

Ambiente Docker completo para aprendizado do Tainacan, a plataforma brasileira de gestão de acervos digitais.

## O que é o Tainacan?

O Tainacan é um software livre desenvolvido para a gestão e publicação de acervos digitais. Ideal para museus, bibliotecas, arquivos e instituições culturais que desejam organizar, preservar e disponibilizar suas coleções online.

## Requisitos

Antes de começar, certifique-se de ter instalado:

- **Docker Desktop** - [Download aqui](https://www.docker.com/products/docker-desktop/)
- **4GB de RAM** disponível para o Docker
- **2GB de espaço em disco** livre
- **Portas livres:** 8080, 8081

### Verificando se o Docker está instalado

Abra o terminal (Prompt de Comando ou PowerShell) e digite:

```bash
docker --version
```

Se aparecer uma versão, o Docker está instalado corretamente.

## Como Iniciar

### 1. Abra o PowerShell na pasta do projeto

```powershell
cd C:\projetos\tainacan-aprendizado
```

### 2. Inicie os containers

```powershell
docker-compose up -d
```

**Primeira execução:** Aguarde o build da imagem (pode demorar alguns minutos).

### 3. Execute o setup (apenas na primeira vez)

Aguarde ~10 segundos após os containers subirem, então execute:

```powershell
docker exec tainacan-wordpress bash /usr/local/bin/setup-tainacan.sh
```

Este comando irá:
- Instalar o WordPress em Português Brasil
- Configurar timezone e formatos brasileiros
- Instalar e ativar o plugin Tainacan
- Configurar permalinks

### 4. Acesse o sistema

Quando a instalação terminar, acesse:

| Serviço | URL | Descrição |
|---------|-----|-----------|
| Site WordPress | http://localhost:8080 | Página inicial do site |
| Painel Admin | http://localhost:8080/wp-admin | Administração do WordPress |
| Tainacan | http://localhost:8080/wp-admin/admin.php?page=tainacan_admin | Interface do Tainacan |
| phpMyAdmin | http://localhost:8081 | Gerenciar banco de dados |

## Credenciais de Acesso

### WordPress / Tainacan

- **Usuário:** `admin`
- **Senha:** `tainacan123`

### phpMyAdmin

- **Servidor:** `db`
- **Usuário:** `wordpress`
- **Senha:** `wordpress`

## Comandos Úteis

### Parar o ambiente (mantém os dados)

```bash
docker-compose down
```

### Reiniciar o ambiente

```bash
docker-compose up -d
```

### Ver o que está rodando

```bash
docker-compose ps
```

### Ver logs em tempo real

```bash
docker-compose logs -f
```

### Recomeçar do zero (apaga todos os dados)

```bash
docker-compose down -v
docker-compose up -d
```

**Atenção:** O comando acima apaga todas as coleções, itens e configurações!

## Estrutura do Projeto

```
tainacan-aprendizado/
├── docker-compose.yml    # Configuração dos serviços
├── Dockerfile            # Imagem customizada do WordPress
├── README.md             # Este arquivo
├── config/
│   └── uploads.ini       # Configurações do PHP
└── scripts/
    └── setup.sh          # Script de instalação
```

## Serviços do Ambiente

| Serviço | Porta | Função |
|---------|-------|--------|
| WordPress | 8080 | Site e painel de administração |
| MariaDB | 3306 | Banco de dados |
| phpMyAdmin | 8081 | Interface visual para o banco |

## Primeiros Passos no Tainacan

Após acessar o Tainacan, você pode:

1. **Criar uma Coleção**
   - Vá em "Coleções" → "Nova Coleção"
   - Defina nome e descrição

2. **Configurar Metadados**
   - Na coleção, vá em "Metadados"
   - Adicione campos como: Título, Descrição, Data, Autor

3. **Adicionar Itens**
   - Clique em "Adicionar Item"
   - Preencha os metadados e faça upload de arquivos

4. **Criar Filtros**
   - Configure filtros para facilitar a busca no acervo

5. **Publicar**
   - Os itens ficam disponíveis no site público

## Solução de Problemas

### "Porta já em uso"

Se a porta 8080 ou 8081 estiver em uso:

1. Pare outros serviços que usam essas portas, ou
2. Edite o arquivo `docker-compose.yml` e mude as portas:
   ```yaml
   ports:
     - "8082:80"  # Muda de 8080 para 8082
   ```

### "Container não inicia"

```bash
# Ver logs de erro
docker-compose logs wordpress

# Reiniciar containers
docker-compose restart
```

### "Instalação não completa"

Se o WordPress não foi configurado automaticamente:

```powershell
# Reexecutar o setup
docker exec tainacan-wordpress bash /usr/local/bin/setup-tainacan.sh
```

### "Docker Desktop não inicia"

- Verifique se a virtualização está habilitada na BIOS
- Reinicie o computador
- Reinstale o Docker Desktop

## Dicas de Uso

1. **Faça backup regularmente**
   - Use o phpMyAdmin para exportar o banco de dados
   - Copie a pasta de uploads via Docker

2. **Não use em produção**
   - Este ambiente é apenas para aprendizado
   - As senhas são simples e conhecidas

3. **Explore a documentação**
   - [Wiki do Tainacan](https://wiki.tainacan.org)
   - [Manual do Usuário](https://tainacan.github.io/tainacan-wiki/)

## Links Úteis

- [Site Oficial do Tainacan](https://tainacan.org)
- [Repositório no GitHub](https://github.com/tainacan/tainacan)
- [Fórum da Comunidade](https://tainacan.discourse.group/)
- [Documentação WordPress](https://br.wordpress.org/support/)

## Suporte

Este é um ambiente de aprendizado. Para dúvidas sobre o Tainacan:

- Acesse o [Fórum da Comunidade](https://tainacan.discourse.group/)
- Consulte a [Wiki](https://wiki.tainacan.org)
- Participe do grupo no [Telegram](https://t.me/tainacan)

---

**Bom aprendizado!** 🏛️
