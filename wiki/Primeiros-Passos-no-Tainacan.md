# Primeiros Passos no Tainacan

Este tutorial vai te ensinar os conceitos básicos do Tainacan e como começar a criar seu acervo digital.

---

## O que é o Tainacan?

O **Tainacan** é um software brasileiro, gratuito e de código aberto, criado para ajudar museus, bibliotecas, arquivos e outras instituições culturais a organizar, preservar e disponibilizar suas coleções na internet.

### Quem usa o Tainacan?

- **Museus** - para catalogar obras de arte, objetos históricos, fotografias
- **Bibliotecas** - para organizar acervos especiais, obras raras
- **Arquivos** - para documentos históricos, fotografias antigas
- **Universidades** - para coleções científicas, herbários, acervos de pesquisa
- **Instituições culturais** - para preservar patrimônio cultural

### O que você pode fazer com o Tainacan?

- Criar coleções organizadas por tema
- Cadastrar itens com fotos, documentos, vídeos
- Definir informações específicas para cada tipo de acervo
- Criar filtros para facilitar buscas
- Disponibilizar o acervo para o público online
- Exportar e importar dados em formatos padrão

---

## Acessando o Painel do Tainacan

### Como fazer login

1. Abra seu navegador
2. Acesse: **http://localhost:8080/wp-admin**
3. Digite suas credenciais:
   - **Usuário:** `admin`
   - **Senha:** `tainacan123`
4. Clique em **Entrar**

### Acessando o Tainacan

Após o login, você estará no painel do WordPress. Para acessar o Tainacan:

**Opção 1:** Clique em **Tainacan** no menu lateral esquerdo

**Opção 2:** Acesse diretamente: http://localhost:8080/wp-admin/admin.php?page=tainacan_admin

### Conhecendo a interface

Ao entrar no Tainacan, você verá:

- **Menu lateral:** Navegação entre Coleções, Taxonomias, etc.
- **Área principal:** Onde você trabalha com seus itens
- **Botões de ação:** Para criar novos elementos

---

## Conceitos Básicos

Antes de começar, é importante entender como o Tainacan organiza as informações:

### Coleções

Uma **coleção** é como uma pasta ou gaveta onde você guarda itens relacionados.

**Exemplos:**
- "Acervo Fotográfico"
- "Obras de Arte"
- "Documentos Históricos"
- "Artesanato Regional"

Cada coleção pode ter suas próprias regras e campos de informação.

### Itens

**Itens** são os objetos do seu acervo - as "coisas" que você está catalogando.

**Exemplos:**
- Uma fotografia específica
- Um quadro
- Um documento
- Uma peça de cerâmica

Cada item pertence a uma coleção e tem informações (metadados) associadas.

### Metadados

**Metadados** são as informações que descrevem cada item. Pense neles como os "campos" de uma ficha catalográfica.

**Exemplos de metadados:**
- Título
- Autor
- Data de criação
- Técnica
- Dimensões
- Localização
- Descrição

Cada coleção pode ter metadados diferentes, adequados ao tipo de acervo.

### Taxonomias

**Taxonomias** são vocabulários controlados - listas de termos padronizados que você cria para classificar seus itens.

**Exemplos:**
- Técnicas artísticas: "Óleo sobre tela", "Aquarela", "Escultura em madeira"
- Períodos: "Colonial", "Imperial", "Republicano"
- Categorias: "Pintura", "Escultura", "Fotografia"

Taxonomias ajudam a manter a consistência e facilitam as buscas.

### Filtros

**Filtros** permitem que os usuários encontrem itens específicos no acervo.

Por exemplo, um filtro por "Técnica" permite que alguém veja apenas pinturas a óleo, ou apenas aquarelas.

---

## Criando sua Primeira Coleção

Vamos criar uma coleção passo a passo!

### Passo 1: Iniciar a criação

1. No painel do Tainacan, clique em **Coleções** no menu lateral
2. Clique no botão **Nova Coleção** (ou no ícone "+")

### Passo 2: Informações básicas

Preencha os campos:

1. **Nome:** Digite o nome da sua coleção
   - Exemplo: "Acervo Fotográfico"

2. **Descrição:** Explique do que se trata a coleção
   - Exemplo: "Fotografias históricas da cidade de São Paulo, cobrindo o período de 1900 a 1950"

3. **Imagem em miniatura:** (Opcional) Clique para adicionar uma imagem que represente a coleção

4. **Imagem de cabeçalho:** (Opcional) Uma imagem maior para o topo da página da coleção

### Passo 3: Configurações da coleção

Na seção de configurações:

1. **Status:** Escolha "Publicado" para a coleção ficar visível, ou "Privado" enquanto trabalha nela

2. **Permitir comentários:** Marque se quiser que visitantes possam comentar

3. **Capa da coleção:** Escolha como a página da coleção será exibida

### Passo 4: Salvar

Clique no botão **Criar** ou **Salvar**

Parabéns! Sua coleção foi criada!

---

## Configurando Metadados

Agora vamos definir quais informações cada item da coleção deve ter.

### Acessando os metadados

1. Entre na coleção que você criou
2. Clique na aba **Metadados** (ou no ícone de engrenagem)

### Metadados padrão

O Tainacan já vem com alguns metadados básicos:
- **Título** - Nome do item
- **Descrição** - Texto descritivo

### Adicionando novos metadados

1. Na lista de tipos de metadados à direita, **arraste** o tipo desejado para a área de metadados

2. Configure o metadado:
   - **Nome:** Como o campo será chamado (ex: "Autor")
   - **Descrição:** Explicação do que deve ser preenchido
   - **Obrigatório:** Marque se este campo deve ser preenchido em todos os itens
   - **Configurações específicas:** Dependem do tipo escolhido

3. Clique em **Salvar**

### Tipos de metadados disponíveis

| Tipo | Para que serve | Exemplo |
|------|----------------|---------|
| **Texto** | Informações curtas | Autor, Título |
| **Texto longo** | Descrições extensas | Histórico da peça |
| **Numérico** | Números | Ano, Quantidade |
| **Data** | Datas | Data de criação |
| **Seleção** | Escolher de uma lista fixa | Status: Bom/Regular/Ruim |
| **Taxonomia** | Usar termos de vocabulário controlado | Técnica, Categoria |
| **Relacionamento** | Conectar a outros itens | "Pertence ao conjunto..." |
| **Usuário** | Associar a um usuário do sistema | Catalogador responsável |

### Dica: Pense no seu acervo

Antes de criar metadados, faça uma lista das informações importantes para o seu tipo de acervo:

**Para um museu de arte:**
- Artista
- Título da obra
- Data de criação
- Técnica
- Dimensões
- Procedência
- Número de tombo

**Para um arquivo fotográfico:**
- Fotógrafo
- Data da foto
- Local
- Pessoas retratadas
- Evento/Ocasião
- Formato original

---

## Adicionando Itens

Agora vamos cadastrar os objetos do seu acervo!

### Passo 1: Acessar a coleção

1. Clique em **Coleções** no menu
2. Clique na coleção onde quer adicionar itens

### Passo 2: Criar novo item

1. Clique no botão **Adicionar novo** (ou ícone "+")
2. Você verá o formulário com os metadados que configurou

### Passo 3: Preencher informações

1. **Documento principal:**
   - Clique em **Definir arquivo** para enviar uma imagem ou documento
   - Formatos aceitos: JPG, PNG, PDF, MP3, MP4, entre outros
   - Tamanho máximo: 100 MB

2. **Miniatura:**
   - Por padrão, usa o documento principal
   - Você pode definir uma imagem diferente se preferir

3. **Metadados:**
   - Preencha os campos que você configurou
   - Campos marcados com * são obrigatórios

### Passo 4: Anexos (opcional)

Você pode adicionar arquivos extras ao item:
- Outras fotografias do objeto
- Documentos relacionados
- Vídeos

Clique em **Anexos** e faça o upload dos arquivos.

### Passo 5: Salvar

1. Escolha o **Status**:
   - **Rascunho:** Ainda trabalhando, não visível ao público
   - **Publicado:** Visível para todos
   - **Privado:** Só você e administradores podem ver

2. Clique em **Salvar** ou **Publicar**

### Adicionando vários itens

Se você tem muitos itens para cadastrar:

**Opção 1: Adicionar em sequência**
- Após salvar um item, clique em **Adicionar novo** para continuar

**Opção 2: Edição em massa**
- O Tainacan permite editar vários itens de uma vez

**Opção 3: Importação**
- Você pode importar dados de planilhas (CSV)
- Consulte a documentação para mais detalhes

---

## Criando Filtros

Filtros ajudam os visitantes a encontrar o que procuram.

### Acessando os filtros

1. Entre na coleção
2. Clique na aba **Filtros**

### Adicionando um filtro

1. Arraste o tipo de filtro desejado para a área de filtros

2. Configure:
   - **Nome:** Como o filtro será exibido
   - **Metadado:** Qual campo será usado para filtrar

3. Clique em **Salvar**

### Tipos de filtros

| Tipo | Funciona com | Como aparece |
|------|--------------|--------------|
| **Lista de seleção** | Texto, Taxonomia | Lista com opções para marcar |
| **Caixa de seleção** | Texto, Taxonomia | Checkboxes |
| **Intervalo numérico** | Números | Controles deslizantes |
| **Intervalo de datas** | Datas | Calendário para escolher período |
| **Busca textual** | Texto | Campo de digitação |

### Exemplo prático

Para uma coleção de fotografias, você poderia criar:

1. **Filtro por Período**
   - Tipo: Intervalo de datas
   - Metadado: Data da foto

2. **Filtro por Local**
   - Tipo: Lista de seleção
   - Metadado: Local (taxonomia)

3. **Filtro por Fotógrafo**
   - Tipo: Caixa de seleção
   - Metadado: Fotógrafo

---

## Publicando o Acervo

### Verificando a visualização pública

Para ver como seu acervo aparece para os visitantes:

1. Acesse **http://localhost:8080** em uma nova aba
2. Ou clique no nome do site no canto superior esquerdo do WordPress

### Status dos itens

Lembre-se que apenas itens com status **Publicado** aparecem para o público.

Para publicar vários itens de uma vez:
1. Na lista de itens, marque os que deseja publicar
2. Use a opção de **Ações em massa**
3. Selecione **Publicar**

### Temas e aparência

O Tainacan funciona com qualquer tema do WordPress. Alguns temas são especialmente projetados para acervos:

- **Flavor do Tainacan:** Tema oficial, otimizado para exibir coleções
- **Interface do Tainacan:** Tema minimalista e moderno

Para mudar o tema:
1. Vá em **Aparência → Temas** no menu do WordPress
2. Escolha e ative o tema desejado

---

## Criando Taxonomias

Taxonomias são vocabulários controlados que você pode usar em várias coleções.

### Quando criar uma taxonomia?

Crie uma taxonomia quando:
- O mesmo conjunto de termos será usado em mais de uma coleção
- Você quer manter um vocabulário padronizado
- Os termos têm relação hierárquica (ex: categorias e subcategorias)

### Passo 1: Criar a taxonomia

1. No menu do Tainacan, clique em **Taxonomias**
2. Clique em **Nova Taxonomia**
3. Preencha:
   - **Nome:** Ex: "Técnicas Artísticas"
   - **Descrição:** Ex: "Vocabulário controlado de técnicas artísticas utilizadas nas obras do acervo"
4. Clique em **Criar**

### Passo 2: Adicionar termos

1. Entre na taxonomia criada
2. Clique em **Novo termo**
3. Digite o nome do termo (ex: "Óleo sobre tela")
4. Opcionalmente, adicione:
   - **Descrição:** Explicação do termo
   - **Termo pai:** Se for uma subcategoria
5. Repita para todos os termos

### Passo 3: Usar a taxonomia em metadados

1. Vá para a coleção desejada
2. Nas configurações de metadados, adicione um metadado do tipo **Taxonomia**
3. Selecione a taxonomia criada
4. Agora, ao cadastrar itens, você poderá escolher termos dessa lista

---

## Próximos Passos

Agora que você conhece o básico, explore mais recursos:

### Documentação oficial

- **Wiki do Tainacan:** https://wiki.tainacan.org
  - Tutoriais completos
  - Guias avançados
  - Referência técnica

### Funcionalidades avançadas

- **Importação de dados:** Cadastre muitos itens de uma vez via CSV
- **Exposição via API:** Conecte seu acervo a outros sistemas
- **Mapeamento de metadados:** Use padrões internacionais como Dublin Core
- **Relatórios:** Gere estatísticas do acervo

### Comunidade

- **Fórum:** https://tainacan.discourse.group
- **Telegram:** Grupo da comunidade Tainacan
- **GitHub:** https://github.com/tainacan/tainacan

### Vídeos tutoriais

O Tainacan tem um canal no YouTube com tutoriais em vídeo:
- Pesquise por "Tainacan tutoriais" no YouTube

---

## Resumo

| Conceito | O que é | Analogia |
|----------|---------|----------|
| **Coleção** | Agrupamento de itens | Uma gaveta ou pasta |
| **Item** | Objeto do acervo | Uma ficha catalográfica |
| **Metadado** | Informação sobre o item | Campos da ficha |
| **Taxonomia** | Vocabulário controlado | Lista de termos padronizados |
| **Filtro** | Forma de buscar itens | Peneira para encontrar itens |

---

## Dicas finais

1. **Comece simples:** Não tente criar tudo de uma vez. Comece com poucos metadados e vá adicionando conforme a necessidade.

2. **Padronize:** Use sempre os mesmos termos para descrever coisas similares. Taxonomias ajudam nisso.

3. **Documente:** Crie descrições claras para seus metadados, explicando o que deve ser preenchido.

4. **Faça backup:** Regularmente, exporte seus dados para ter uma cópia de segurança.

5. **Explore:** O Tainacan tem muitos recursos. Use este ambiente de aprendizado para experimentar sem medo!

---

**[Voltar para a página inicial](Home)** | **[Tutorial de instalação](Instalando-o-Ambiente)**
