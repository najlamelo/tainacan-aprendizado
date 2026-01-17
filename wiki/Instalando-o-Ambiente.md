# Instalando o Ambiente Tainacan

Este tutorial vai te guiar passo a passo para instalar e usar o ambiente de aprendizado do Tainacan no seu computador.

---

## O que é Docker?

Imagine que você comprou um móvel que vem desmontado. Você precisa ler o manual, separar as peças, pegar ferramentas... Dá trabalho, né?

Agora imagine se o móvel viesse **já montado dentro de uma caixa mágica**. Você só abre a caixa e ele está pronto para usar!

O **Docker** funciona assim: ele cria "caixas" (chamadas de *containers*) que já vêm com tudo instalado e configurado. No nosso caso, a "caixa" contém:
- Um servidor web
- Um banco de dados
- O WordPress
- O Tainacan

Você não precisa instalar nada disso manualmente. O Docker faz tudo por você!

---

## Passo 1: Instalar o Docker Desktop

### 1.1 Baixar o Docker Desktop

1. Abra seu navegador (Chrome, Firefox, Edge...)
2. Acesse: **https://www.docker.com/products/docker-desktop/**
3. Clique no botão azul **"Download for Windows"**
4. O download vai começar automaticamente (arquivo de aproximadamente 500 MB)

### 1.2 Instalar o Docker Desktop

1. Localize o arquivo baixado (geralmente na pasta "Downloads")
   - O nome será algo como `Docker Desktop Installer.exe`

2. **Dê duplo-clique** no arquivo para iniciar a instalação

3. Se aparecer uma janela perguntando "Deseja permitir que este aplicativo faça alterações no seu dispositivo?", clique em **Sim**

4. Na tela de configuração, **deixe as opções marcadas como estão** e clique em **OK**

5. Aguarde a instalação (pode levar alguns minutos)

6. Quando terminar, clique em **Close and restart** (Fechar e reiniciar)
   - Seu computador será reiniciado

### 1.3 Configuração inicial do Docker

Após o computador reiniciar:

1. O Docker Desktop deve abrir automaticamente
   - Se não abrir, procure por "Docker Desktop" no menu Iniciar

2. Na primeira vez, ele pode pedir para você aceitar os termos de uso
   - Marque a caixa "I accept the terms" e clique em **Accept**

3. Você verá uma tela de tutorial do Docker
   - Pode pular clicando em **Skip tutorial**

4. O Docker está pronto quando você ver a **baleia azul** na barra de tarefas (perto do relógio)

### 1.4 Verificar se o Docker está funcionando

Para ter certeza que tudo está certo:

1. Abra o **Prompt de Comando** (pesquise por "cmd" no menu Iniciar)

2. Digite o comando abaixo e pressione **Enter**:
   ```
   docker --version
   ```

3. Se aparecer algo como `Docker version 24.0.0, build...` está funcionando!

---

## Passo 2: Baixar os arquivos do projeto

### Opção A: Se você recebeu uma pasta zipada

1. Localize o arquivo `.zip` que você recebeu
2. **Clique com o botão direito** no arquivo
3. Selecione **"Extrair tudo..."**
4. Escolha o local: `C:\projetos\` (crie esta pasta se não existir)
5. Clique em **Extrair**

### Opção B: Se você tem acesso ao GitHub

1. Abra o Prompt de Comando (cmd)
2. Execute os comandos:
   ```
   mkdir C:\projetos
   cd C:\projetos
   git clone https://github.com/SEU-USUARIO/tainacan-aprendizado.git
   ```

---

## Passo 3: Iniciar o ambiente Tainacan

### Opção Fácil: Usando o instalador automático

1. Abra a pasta do projeto:
   - `C:\projetos\tainacan-aprendizado`

2. **Dê duplo-clique** no arquivo `instalar.bat`

3. Uma janela preta (Prompt de Comando) vai abrir mostrando o progresso

4. Aguarde até ver a mensagem de sucesso

5. Pronto! O ambiente está rodando!

### Opção Manual: Usando comandos

Se preferir fazer manualmente ou se o instalador não funcionar:

1. Abra o **Prompt de Comando** (cmd)

2. Navegue até a pasta do projeto:
   ```
   cd C:\projetos\tainacan-aprendizado
   ```

3. Inicie os containers:
   ```
   docker-compose up -d
   ```

   > O `-d` significa "detached" (em segundo plano), assim o terminal fica livre

4. Aguarde os downloads (só na primeira vez, pode levar alguns minutos)

5. Execute a configuração inicial:
   ```
   docker exec tainacan-wordpress setup-tainacan.sh
   ```

6. Aguarde a mensagem de sucesso

---

## Passo 4: Acessar o Tainacan

Após a instalação, você pode acessar:

### Site principal
- **Endereço:** http://localhost:8080
- Este é o site WordPress com o Tainacan instalado

### Painel de administração
- **Endereço:** http://localhost:8080/wp-admin
- **Usuário:** `admin`
- **Senha:** `tainacan123`

### Painel do Tainacan
- **Endereço:** http://localhost:8080/wp-admin/admin.php?page=tainacan_admin
- Ou acesse pelo menu lateral no painel WordPress

### phpMyAdmin (para ver o banco de dados)
- **Endereço:** http://localhost:8081
- **Usuário:** `wordpress`
- **Senha:** `wordpress`
- *Use apenas se precisar ver os dados diretamente no banco*

---

## Comandos do dia a dia

### Ligar o ambiente

Sempre que quiser usar o Tainacan:

1. Abra o **Docker Desktop** (se não estiver aberto)
2. Abra o **Prompt de Comando**
3. Execute:
   ```
   cd C:\projetos\tainacan-aprendizado
   docker-compose up -d
   ```

### Desligar o ambiente

Quando terminar de usar:

```
cd C:\projetos\tainacan-aprendizado
docker-compose down
```

> **Importante:** Seus dados ficam salvos mesmo após desligar!

### Verificar se está funcionando

Para ver se os containers estão rodando:

```
docker ps
```

Você deve ver três containers: `tainacan-wordpress`, `tainacan-db` e `tainacan-phpmyadmin`

### Ver o que está acontecendo (logs)

Se algo parecer errado, você pode ver os logs:

```
cd C:\projetos\tainacan-aprendizado
docker-compose logs -f wordpress
```

Pressione `Ctrl + C` para sair dos logs

---

## Problemas comuns e soluções

### "Docker não está rodando"

**Sintoma:** Ao executar comandos docker, aparece erro dizendo que o Docker não está rodando.

**Solução:**
1. Procure o ícone da baleia azul na barra de tarefas (perto do relógio)
2. Se não estiver lá, abra o **Docker Desktop** pelo menu Iniciar
3. Aguarde até a baleia parar de se mexer (indica que está pronto)
4. Tente novamente

### "Porta já está em uso"

**Sintoma:** Erro mencionando que a porta 8080 ou 8081 está ocupada.

**Solução:**
1. Verifique se você não tem outro servidor web rodando (XAMPP, WAMP, etc.)
2. Feche esses programas e tente novamente
3. Se precisar, você pode mudar as portas no arquivo `docker-compose.yml`

### "Não consigo acessar localhost:8080"

**Sintoma:** O navegador mostra erro ou página não encontrada.

**Solução:**
1. Verifique se os containers estão rodando com `docker ps`
2. Se não estiverem, inicie com `docker-compose up -d`
3. Aguarde 1-2 minutos para o WordPress inicializar
4. Tente novamente

### "O site carrega mas está em inglês"

**Sintoma:** WordPress instalou em inglês em vez de português.

**Solução:**
1. Acesse http://localhost:8080/wp-admin
2. Vá em **Settings → General**
3. Em "Site Language", selecione "Português do Brasil"
4. Clique em **Save Changes**

### "Quero começar do zero"

**Solução:** Para apagar tudo e recomeçar:
```
cd C:\projetos\tainacan-aprendizado
docker-compose down -v
docker-compose up -d
docker exec tainacan-wordpress setup-tainacan.sh
```

> **Atenção:** Isso apaga TODOS os dados, incluindo coleções e itens que você criou!

---

## Próximos passos

Agora que seu ambiente está funcionando, veja o tutorial:

**[Primeiros Passos no Tainacan](Primeiros-Passos-no-Tainacan)**

---

## Precisa de ajuda?

- **Documentação oficial do Tainacan:** https://wiki.tainacan.org
- **Documentação do Docker:** https://docs.docker.com
