# Ambiente de Aprendizado Tainacan

Bem-vindo ao ambiente de aprendizado do Tainacan!

Este projeto foi criado para permitir que você aprenda a usar o **Tainacan** de forma prática, sem precisar configurar servidores ou se preocupar com aspectos técnicos.

---

## O que é este projeto?

Um ambiente completo e autocontido que inclui:
- WordPress configurado em português
- Plugin Tainacan instalado e ativado
- Banco de dados MariaDB
- Interface phpMyAdmin para visualizar dados

Tudo isso roda no seu computador através do Docker, de forma isolada e segura.

---

## Tutoriais

### 1. Instalando o Ambiente
**[Instalando o Ambiente](Instalando-o-Ambiente)**

Guia completo para instalar o ambiente ou compartilhar com outras pessoas.

**Conteúdo:**
- Como compartilhar o projeto (ZIP ou GitHub)
- Verificar pré-requisitos (WSL, virtualização)
- Instalar Docker Desktop e Git
- Iniciar o ambiente Tainacan
- Comandos do dia a dia
- Solução de problemas comuns

---

### 2. Primeiros Passos no Tainacan
**[Primeiros Passos no Tainacan](Primeiros-Passos-no-Tainacan)**

Aprenda a usar o Tainacan para criar e gerenciar seu acervo digital.

**Conteúdo:**
- O que é o Tainacan
- Conceitos básicos (Coleções, Itens, Metadados)
- Criando sua primeira coleção
- Configurando metadados
- Adicionando itens ao acervo
- Criando filtros
- Publicando o acervo

---

## Acesso Rápido

Após iniciar o ambiente, acesse:

| Recurso | Endereço | Credenciais |
|---------|----------|-------------|
| **Site WordPress** | http://localhost:8080 | - |
| **Painel Admin** | http://localhost:8080/wp-admin | admin / tainacan123 |
| **Painel Tainacan** | [Acesso direto](http://localhost:8080/wp-admin/admin.php?page=tainacan_admin) | (mesmo do admin) |
| **phpMyAdmin** | http://localhost:8081 | wordpress / wordpress |

---

## Comandos Úteis

```bash
# Iniciar o ambiente
docker-compose up -d

# Parar o ambiente
docker-compose down

# Ver se está funcionando
docker ps

# Recomeçar do zero (apaga tudo!)
docker-compose down -v
docker-compose up -d
docker exec tainacan-wordpress setup-tainacan.sh
```

---

## Recursos Adicionais

### Documentação Oficial
- [Wiki do Tainacan](https://wiki.tainacan.org)
- [Site oficial](https://tainacan.org)
- [Repositório GitHub](https://github.com/tainacan/tainacan)

### Comunidade
- [Fórum da comunidade](https://tainacan.discourse.group)
- [Canal YouTube](https://www.youtube.com/results?search_query=tainacan)

---

## Sobre

Este projeto foi criado para facilitar o aprendizado do Tainacan por museólogos, arquivistas, bibliotecários e outros profissionais da informação.

**Licença:** MIT

---

*Dúvidas ou sugestões? Abra uma issue no repositório!*
