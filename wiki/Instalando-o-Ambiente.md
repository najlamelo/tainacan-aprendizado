# Instalando o Ambiente Tainacan

Este guia completo ensina como instalar o ambiente Tainacan no seu computador ou compartilhá-lo com outras pessoas.

---

## Para quem quer compartilhar o projeto

Se você já tem o ambiente funcionando e quer enviar para outra pessoa, siga uma das opções abaixo:

### Opção A: Enviar como arquivo ZIP

1. Vá até a pasta `C:\projetos\`
2. Clique com o botão direito na pasta `tainacan-aprendizado`
3. Selecione **"Compactar para arquivo ZIP"**
4. Envie o arquivo `tainacan-aprendizado.zip` por email, Google Drive, pendrive, etc.

### Opção B: Compartilhar via GitHub

Envie o link do repositório:
```
https://github.com/najlamelo/tainacan-aprendizado
```

A pessoa que receber deve seguir o guia abaixo.

---

# GUIA DE INSTALAÇÃO

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

### Opção A: Se recebeu um arquivo ZIP (mais simples)

1. Localize o arquivo `tainacan-aprendizado.zip`
2. Clique com o botão direito e selecione **"Extrair tudo..."**
3. No campo de destino, digite: `C:\projetos\`
4. Clique em **Extrair**

A pasta final deve ficar em: `C:\projetos\tainacan-aprendizado`

**Pule para a Etapa 4.**

---

### Opção B: Se recebeu um link do GitHub

Para baixar do GitHub, você precisa do **Git** instalado. Siga os passos abaixo.

#### 3.1 Verificar se o Git está instalado

1. Pressione **Windows + X**
2. Clique em **Terminal** ou **PowerShell**
3. Digite o comando:

```
git --version
```

**Se aparecer** `git version 2.x.x`:
- O Git já está instalado. Pule para o passo **3.3**.

**Se aparecer** "não é reconhecido" ou erro:
- O Git não está instalado. Continue no passo **3.2**.

#### 3.2 Instalar o Git

1. Acesse: **https://git-scm.com/download/win**
2. O download deve começar automaticamente (arquivo de ~50 MB)
3. Execute o instalador baixado (`Git-2.x.x-64-bit.exe`)
4. **Clique em Next** em todas as telas (as opções padrão estão corretas)
5. Clique em **Install** e aguarde
6. Clique em **Finish**

**Importante:** Feche e abra novamente o Terminal/PowerShell para que o Git seja reconhecido.

#### 3.3 Verificar se o Git funciona

Abra um novo Terminal e execute:

```
git --version
```

Deve mostrar: `git version 2.x.x.windows.x`

#### 3.4 Criar a pasta e baixar o projeto

No Terminal, execute os comandos abaixo (um por vez):

```
cd C:\
mkdir projetos
cd projetos
git clone https://github.com/najlamelo/tainacan-aprendizado.git
```

Aguarde o download terminar. A pasta será criada em: `C:\projetos\tainacan-aprendizado`

---

### Opção C: Baixar do GitHub sem instalar Git

Se preferir não instalar o Git:

1. Acesse: **https://github.com/najlamelo/tainacan-aprendizado**
2. Clique no botão verde **"Code"**
3. Clique em **"Download ZIP"**
4. Extraia o arquivo baixado em `C:\projetos\`
5. **Renomeie** a pasta de `tainacan-aprendizado-main` para `tainacan-aprendizado`

A pasta final deve ficar em: `C:\projetos\tainacan-aprendizado`

---

## Etapa 4: Iniciar o ambiente pelo Docker Desktop

Todos os comandos serão executados no **terminal do Docker Desktop**. Isso é mais simples do que usar o Prompt de Comando do Windows.

### 4.1 Abrir o terminal do Docker Desktop

1. Abra o **Docker Desktop**
2. Na parte inferior da janela, você verá uma área escura - este é o **terminal integrado**
3. Se não aparecer, clique no ícone **">_"** (terminal) na barra inferior

### 4.2 Navegar até a pasta do projeto

No terminal do Docker Desktop, digite o comando abaixo e pressione **Enter**:

```
cd /c/projetos/tainacan-aprendizado
```

> **Nota:** No terminal do Docker, usamos `/c/` em vez de `C:\`

### 4.3 Verificar se a pasta existe

Se você seguiu a Etapa 3, a pasta já deve existir. Verifique com:

```
ls /c/projetos/tainacan-aprendizado
```

Deve mostrar os arquivos: `docker-compose.yml`, `Dockerfile`, `README.md`, etc.

**Se a pasta não existir**, volte para a Etapa 3 e siga uma das opções (A, B ou C).

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

### "git não é reconhecido" ou "git is not recognized"

O Git não está instalado no computador.

**Solução:**
1. Acesse: **https://git-scm.com/download/win**
2. Baixe e instale (clique Next em tudo)
3. **Feche e abra** o Terminal novamente
4. Tente o comando `git --version`

**Alternativa:** Baixe o projeto como ZIP diretamente do GitHub (veja Etapa 3, Opção C).

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

### "WSL integration with distro 'Ubuntu' unexpectedly stopped"

Este erro aparece como uma janela pop-up do Docker Desktop dizendo que a integração WSL parou inesperadamente.

**Solução:**
1. Na janela de erro, clique no botão **"Restart the WSL integration"**
2. Aguarde alguns segundos
3. O Docker Desktop deve voltar a funcionar normalmente

**Se o botão não funcionar:**
1. Feche o Docker Desktop completamente
2. Abra o Terminal como Administrador
3. Execute: `wsl --shutdown`
4. Aguarde 10 segundos
5. Abra o Docker Desktop novamente

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

## Próximos passos

Agora que seu ambiente está funcionando, aprenda a usar o Tainacan:

**[[Primeiros-Passos-no-Tainacan]]**

---

## Precisa de ajuda?

- **Documentação oficial do Tainacan:** https://wiki.tainacan.org
- **Documentação do Docker:** https://docs.docker.com/desktop/

---

**[[Home|Voltar para o início]]**
