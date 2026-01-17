# Distribuindo o Ambiente para Outros Computadores

Este guia ensina como compartilhar o ambiente Tainacan com outras pessoas, para que elas possam rodar em seus próprios computadores.

---

## Visão Geral

Para usar o ambiente Tainacan, a pessoa precisa:
1. Ter o **Docker Desktop** instalado
2. Ter os **arquivos do projeto**
3. Executar alguns comandos simples

---

## Passo 1: Preparar os arquivos para envio

### Opção A: Enviar como arquivo ZIP

No seu computador, crie um arquivo ZIP com o projeto:

1. Vá até a pasta `C:\projetos\`
2. Clique com o botão direito na pasta `tainacan-aprendizado`
3. Selecione **"Compactar para arquivo ZIP"** (ou "Enviar para > Pasta compactada")
4. Envie o arquivo `tainacan-aprendizado.zip` por email, Google Drive, pendrive, etc.

### Opção B: Compartilhar via GitHub

Se o projeto está no GitHub, basta enviar o link do repositório:
```
https://github.com/SEU-USUARIO/tainacan-aprendizado
```

---

## Passo 2: Instruções para quem vai receber

Envie as instruções abaixo para a pessoa que vai usar o ambiente.

---

# GUIA DE INSTALAÇÃO DO TAINACAN
*(Copie daqui para baixo e envie para o usuário)*

---

## Requisitos do Sistema

- Windows 10 (versão 1903 ou superior) ou Windows 11 (64 bits)
- 8 GB de RAM (mínimo)
- 10 GB de espaço em disco livre
- Conexão com internet (para baixar o Docker e as imagens)
- **WSL 2** (Subsistema Windows para Linux) - veja como verificar abaixo
- **Virtualização** habilitada na BIOS/UEFI

---

## Etapa 1: Verificar e Preparar o Windows

Antes de instalar o Docker, precisamos garantir que seu Windows está preparado. Siga **todos os passos** desta etapa.

### 1.1 Verificar se o WSL está instalado

1. Pressione as teclas **Windows + X**
2. Clique em **Terminal (Admin)** ou **PowerShell (Admin)**
3. Se perguntar sobre permissões, clique em **Sim**
4. Digite o comando abaixo e pressione **Enter**:

```
wsl --status
```

**Se aparecer informações sobre o WSL** (versão, kernel, etc.):
- O WSL já está instalado. Pule para o passo **1.3**.

**Se aparecer erro ou "não reconhecido":**
- O WSL não está instalado. Continue no passo **1.2**.

### 1.2 Instalar o WSL 2

No mesmo terminal (como Administrador), execute:

```
wsl --install
```

**O que vai acontecer:**
- O Windows vai baixar e instalar o WSL 2
- Também instalará o Ubuntu como distribuição Linux padrão
- **Será necessário reiniciar o computador**

Após reiniciar:
1. Uma janela do Ubuntu pode abrir pedindo para criar usuário
2. Você pode fechar essa janela - não precisamos do Ubuntu, apenas do WSL
3. Continue para o passo **1.3**

### 1.3 Verificar os Recursos do Windows

Precisamos garantir que alguns recursos estão ativados:

1. Pressione a tecla **Windows** e digite: `Ativar ou desativar recursos do Windows`
2. Clique no resultado que aparecer
3. Na janela que abrir, **marque** (se não estiverem marcados):
   - ☑ **Hyper-V** (pode não aparecer em versões Home do Windows)
   - ☑ **Plataforma de Máquina Virtual**
   - ☑ **Subsistema do Windows para Linux**
4. Clique em **OK**
5. Se pedir para reiniciar, **reinicie o computador**

### 1.4 Verificar se a Virtualização está ativada

A virtualização precisa estar ativada na BIOS/UEFI do computador.

**Para verificar:**
1. Pressione **Ctrl + Shift + Esc** para abrir o Gerenciador de Tarefas
2. Clique na aba **Desempenho**
3. Clique em **CPU**
4. Procure por **"Virtualização"** na parte inferior direita
   - Se mostrar **"Habilitado"** ou **"Enabled"**: Está tudo certo!
   - Se mostrar **"Desabilitado"** ou **"Disabled"**: Veja a seção "Problemas Comuns" no final deste guia

### 1.5 Confirmar que está tudo pronto

Abra novamente o Terminal como Administrador e execute:

```
wsl --version
```

Deve mostrar algo como:
```
Versão do WSL: 2.x.x.x
Versão do kernel: 5.x.x.x
...
```

Se aparecer essas informações, **parabéns!** Seu Windows está pronto para o Docker.

---

## Etapa 2: Instalar o Docker Desktop

### 2.1 Baixar o Docker Desktop

1. Acesse: **https://www.docker.com/products/docker-desktop/**
2. Clique no botão **"Download for Windows"**
3. Aguarde o download (aproximadamente 500 MB)

### 2.2 Instalar

1. Dê **duplo-clique** no arquivo baixado (`Docker Desktop Installer.exe`)
2. Se perguntar sobre permissões, clique em **Sim**
3. Na tela de configuração, certifique-se que **"Use WSL 2 instead of Hyper-V"** está marcado
4. Clique em **OK** e aguarde a instalação terminar
5. Clique em **"Close and restart"** - o computador vai reiniciar

### 2.3 Primeira execução

Após reiniciar:

1. O Docker Desktop deve abrir automaticamente
   - Se não abrir, procure por **"Docker Desktop"** no menu Iniciar
2. Aceite os termos de uso (marque a caixa e clique **Accept**)
3. Pule o tutorial clicando em **"Skip tutorial"**
4. Aguarde até aparecer **"Docker Desktop is running"** (pode levar 1-2 minutos)

---

## Etapa 3: Colocar os arquivos do projeto no computador

### Se recebeu um arquivo ZIP:

1. Localize o arquivo `tainacan-aprendizado.zip`
2. Clique com o botão direito e selecione **"Extrair tudo..."**
3. No campo de destino, digite: `C:\projetos\`
4. Clique em **Extrair**

A pasta final deve ficar em: `C:\projetos\tainacan-aprendizado`

### Se recebeu um link do GitHub:

Você fará o download direto pelo terminal do Docker (veja a próxima etapa).

---

## Etapa 4: Iniciar o ambiente pelo Docker Desktop

Todos os comandos serão executados no **terminal do Docker Desktop**. Isso é mais simples do que usar o Prompt de Comando do Windows.

### 4.1 Abrir o terminal do Docker Desktop

1. Abra o **Docker Desktop**
2. Na parte inferior da janela, você verá uma área escura - este é o **terminal integrado**
3. Se não aparecer, clique no ícone **">_"** (terminal) na barra inferior

*(Imagem: O terminal fica na parte de baixo da janela do Docker Desktop)*

### 4.2 Navegar até a pasta do projeto

No terminal do Docker Desktop, digite o comando abaixo e pressione **Enter**:

```
cd /c/projetos/tainacan-aprendizado
```

> **Nota:** No terminal do Docker, usamos `/c/` em vez de `C:\`

### 4.3 (Opcional) Se recebeu link do GitHub

Se você ainda não tem os arquivos e recebeu um link do GitHub, execute:

```
cd /c
mkdir -p projetos
cd projetos
git clone https://github.com/USUARIO/tainacan-aprendizado.git
cd tainacan-aprendizado
```

*(Substitua USUARIO pelo nome correto)*

### 4.4 Iniciar os containers

Execute o comando:

```
docker-compose up -d
```

**O que vai acontecer:**
- Na primeira vez, o Docker vai baixar as imagens necessárias (pode levar 5-10 minutos)
- Você verá mensagens de download e criação dos containers
- Quando terminar, verá: `Creating tainacan-wordpress ... done`

### 4.5 Configurar o WordPress e Tainacan

Após os containers iniciarem, execute:

```
docker exec tainacan-wordpress setup-tainacan.sh
```

**Aguarde** até ver a mensagem de sucesso. Isso pode levar 1-2 minutos.

---

## Etapa 5: Acessar o Tainacan

Abra seu navegador e acesse:

| O que | Endereço | Usuário | Senha |
|-------|----------|---------|-------|
| **Site** | http://localhost:8080 | - | - |
| **Painel Admin** | http://localhost:8080/wp-admin | admin | tainacan123 |
| **Tainacan** | http://localhost:8080/wp-admin/admin.php?page=tainacan_admin | admin | tainacan123 |

---

## Comandos do dia a dia

Sempre use o **terminal do Docker Desktop** para executar estes comandos.

### Verificar se o Docker está no diretório correto

Sempre comece com:
```
cd /c/projetos/tainacan-aprendizado
```

### Ligar o ambiente

```
docker-compose up -d
```

### Desligar o ambiente

```
docker-compose down
```

### Ver se está funcionando

```
docker ps
```

Deve mostrar 3 containers: `tainacan-wordpress`, `tainacan-db`, `tainacan-phpmyadmin`

### Recomeçar do zero (apaga todos os dados!)

```
docker-compose down -v
docker-compose up -d
docker exec tainacan-wordpress setup-tainacan.sh
```

---

## Problemas Comuns

### "WSL não está instalado" ou "wsl não é reconhecido"

**Solução:**
1. Abra o Terminal como Administrador
2. Execute: `wsl --install`
3. Reinicie o computador
4. Tente novamente

### "Virtualização está desabilitada"

A virtualização precisa ser ativada na BIOS/UEFI. O processo varia conforme o fabricante:

**Para acessar a BIOS:**
1. Reinicie o computador
2. Pressione repetidamente a tecla de acesso à BIOS durante a inicialização:
   - **Dell, Lenovo:** F2
   - **HP:** F10 ou Esc
   - **Asus, Acer:** F2 ou Del
   - **MSI:** Del

**Na BIOS, procure por:**
- "Intel Virtualization Technology" ou "Intel VT-x" → **Enable**
- "AMD-V" ou "SVM Mode" → **Enable**
- Geralmente fica em: Advanced → CPU Configuration

Salve (F10) e reinicie.

### "O Docker Desktop não abre" ou "Docker failed to start"

1. Verifique se o WSL 2 está instalado (veja Etapa 1)
2. Verifique se a virtualização está ativada (veja acima)
3. Abra o Terminal como Administrador e execute:
   ```
   wsl --update
   wsl --set-default-version 2
   ```
4. Reinicie o computador
5. Tente abrir o Docker Desktop novamente

### "Não consigo acessar localhost:8080"

1. Verifique se o Docker Desktop está aberto e rodando
2. No terminal, execute `docker ps` para ver se os containers estão ativos
3. Aguarde 1-2 minutos após iniciar os containers
4. Tente usar `http://127.0.0.1:8080` em vez de `localhost`

### "Erro: No such file or directory"

Verifique se você está na pasta correta:
```
cd /c/projetos/tainacan-aprendizado
ls
```

Deve mostrar os arquivos: `docker-compose.yml`, `Dockerfile`, `README.md`, etc.

Se a pasta não existir, crie-a:
```
mkdir -p /c/projetos
```

### "Porta 8080 já está em uso"

Outro programa está usando a porta. Feche programas como XAMPP, WAMP, Skype, ou altere a porta no arquivo `docker-compose.yml`.

### "Windows Home não tem Hyper-V"

O Windows Home não inclui Hyper-V, mas isso não é problema! O Docker Desktop usa WSL 2 no lugar. Apenas certifique-se de que:
1. WSL 2 está instalado
2. "Plataforma de Máquina Virtual" está ativada nos recursos do Windows

---

## Resumo dos Comandos

| Ação | Comando |
|------|---------|
| Ir para a pasta | `cd /c/projetos/tainacan-aprendizado` |
| Ligar | `docker-compose up -d` |
| Desligar | `docker-compose down` |
| Ver status | `docker ps` |
| Setup inicial | `docker exec tainacan-wordpress setup-tainacan.sh` |
| Resetar tudo | `docker-compose down -v && docker-compose up -d && docker exec tainacan-wordpress setup-tainacan.sh` |

---

## Precisa de ajuda?

- **Tutorial completo do Tainacan:** [[Primeiros-Passos-no-Tainacan]]
- **Documentação oficial:** https://wiki.tainacan.org
- **Documentação Docker:** https://docs.docker.com/desktop/

---

**[[Home|Voltar para o início]]**
