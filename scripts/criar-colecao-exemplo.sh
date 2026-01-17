#!/bin/bash
# ===========================================
# Cria uma coleção de exemplo no Tainacan
# Para fins de aprendizado e demonstração
# ===========================================

cd /var/www/html

echo "Criando coleção de exemplo no Tainacan..."
echo ""

# Criar a coleção usando a API REST via WP-CLI
COLLECTION_ID=$(wp eval '
$collection = new \Tainacan\Entities\Collection();
$collection->set_name("Acervo de Demonstração");
$collection->set_description("Coleção de exemplo para aprendizado do Tainacan. Contém itens fictícios de um acervo museológico.");
$collection->set_status("publish");

$Tainacan_Collections = \Tainacan\Repositories\Collections::get_instance();
$collection = $Tainacan_Collections->insert($collection);

echo $collection->get_id();
' --allow-root 2>/dev/null)

if [ -z "$COLLECTION_ID" ] || [ "$COLLECTION_ID" = "0" ]; then
  echo "ERRO: Não foi possível criar a coleção."
  exit 1
fi

echo "Coleção criada com ID: $COLLECTION_ID"

# Criar metadados
echo "Criando metadados..."

# Metadado: Autor/Artista
wp eval "
\$metadata = new \Tainacan\Entities\Metadatum();
\$metadata->set_name('Autor/Artista');
\$metadata->set_description('Nome do autor ou artista responsável pela obra');
\$metadata->set_collection_id($COLLECTION_ID);
\$metadata->set_metadata_type('Tainacan\Metadata_Types\Text');
\$metadata->set_status('publish');
\$Tainacan_Metadata = \Tainacan\Repositories\Metadata::get_instance();
\$Tainacan_Metadata->insert(\$metadata);
echo 'Metadado Autor/Artista criado';
" --allow-root

# Metadado: Data de Criação
wp eval "
\$metadata = new \Tainacan\Entities\Metadatum();
\$metadata->set_name('Data de Criação');
\$metadata->set_description('Data aproximada ou exata de criação da obra');
\$metadata->set_collection_id($COLLECTION_ID);
\$metadata->set_metadata_type('Tainacan\Metadata_Types\Date');
\$metadata->set_status('publish');
\$Tainacan_Metadata = \Tainacan\Repositories\Metadata::get_instance();
\$Tainacan_Metadata->insert(\$metadata);
echo 'Metadado Data de Criação criado';
" --allow-root

# Metadado: Técnica
wp eval "
\$metadata = new \Tainacan\Entities\Metadatum();
\$metadata->set_name('Técnica');
\$metadata->set_description('Técnica utilizada na produção da obra');
\$metadata->set_collection_id($COLLECTION_ID);
\$metadata->set_metadata_type('Tainacan\Metadata_Types\Text');
\$metadata->set_status('publish');
\$Tainacan_Metadata = \Tainacan\Repositories\Metadata::get_instance();
\$Tainacan_Metadata->insert(\$metadata);
echo 'Metadado Técnica criado';
" --allow-root

# Metadado: Dimensões
wp eval "
\$metadata = new \Tainacan\Entities\Metadatum();
\$metadata->set_name('Dimensões');
\$metadata->set_description('Dimensões físicas da obra (altura x largura x profundidade)');
\$metadata->set_collection_id($COLLECTION_ID);
\$metadata->set_metadata_type('Tainacan\Metadata_Types\Text');
\$metadata->set_status('publish');
\$Tainacan_Metadata = \Tainacan\Repositories\Metadata::get_instance();
\$Tainacan_Metadata->insert(\$metadata);
echo 'Metadado Dimensões criado';
" --allow-root

# Metadado: Localização
wp eval "
\$metadata = new \Tainacan\Entities\Metadatum();
\$metadata->set_name('Localização');
\$metadata->set_description('Local atual onde a obra está armazenada ou exposta');
\$metadata->set_collection_id($COLLECTION_ID);
\$metadata->set_metadata_type('Tainacan\Metadata_Types\Text');
\$metadata->set_status('publish');
\$Tainacan_Metadata = \Tainacan\Repositories\Metadata::get_instance();
\$Tainacan_Metadata->insert(\$metadata);
echo 'Metadado Localização criado';
" --allow-root

echo ""
echo "Criando itens de exemplo..."

# Função para criar item
criar_item() {
  local titulo="$1"
  local descricao="$2"
  local autor="$3"
  local data="$4"
  local tecnica="$5"
  local dimensoes="$6"
  local localizacao="$7"

  wp eval "
\$item = new \Tainacan\Entities\Item();
\$item->set_title('$titulo');
\$item->set_description('$descricao');
\$item->set_collection_id($COLLECTION_ID);
\$item->set_status('publish');

\$Tainacan_Items = \Tainacan\Repositories\Items::get_instance();
\$item = \$Tainacan_Items->insert(\$item);

// Buscar metadados da coleção
\$Tainacan_Metadata = \Tainacan\Repositories\Metadata::get_instance();
\$Tainacan_Item_Metadata = \Tainacan\Repositories\Item_Metadata::get_instance();
\$metadata_list = \$Tainacan_Metadata->fetch_by_collection(\$item->get_collection(), [], 'OBJECT');

foreach (\$metadata_list as \$metadata) {
  \$item_metadata = new \Tainacan\Entities\Item_Metadata_Entity(\$item, \$metadata);

  switch (\$metadata->get_name()) {
    case 'Autor/Artista':
      \$item_metadata->set_value('$autor');
      break;
    case 'Data de Criação':
      \$item_metadata->set_value('$data');
      break;
    case 'Técnica':
      \$item_metadata->set_value('$tecnica');
      break;
    case 'Dimensões':
      \$item_metadata->set_value('$dimensoes');
      break;
    case 'Localização':
      \$item_metadata->set_value('$localizacao');
      break;
  }

  if (\$item_metadata->get_value()) {
    \$Tainacan_Item_Metadata->insert(\$item_metadata);
  }
}

echo 'Item criado: $titulo';
" --allow-root
}

# Criar 5 itens de exemplo
criar_item \
  "Vaso Marajoara" \
  "Vaso cerimonial em cerâmica com padrões geométricos típicos da cultura marajoara. Peça encontrada na Ilha de Marajó, Pará." \
  "Cultura Marajoara" \
  "1200-01-01" \
  "Cerâmica pintada" \
  "35cm x 25cm" \
  "Reserva Técnica A - Prateleira 3"

criar_item \
  "Máscara Ritual Kayapó" \
  "Máscara utilizada em rituais de passagem do povo Kayapó. Confeccionada com fibras naturais e pigmentos vegetais." \
  "Povo Kayapó" \
  "1950-01-01" \
  "Fibras naturais e pigmentos" \
  "45cm x 30cm x 15cm" \
  "Reserva Técnica B - Armário 2"

criar_item \
  "Tear Manual Nordestino" \
  "Tear de madeira utilizado para produção de redes e tecidos no sertão nordestino. Exemplar do início do século XX." \
  "Artesão desconhecido" \
  "1920-01-01" \
  "Madeira e cordas" \
  "150cm x 80cm x 100cm" \
  "Sala de Exposição - Setor Nordeste"

criar_item \
  "Berimbau de Capoeira" \
  "Instrumento musical tradicional da capoeira baiana. Inclui verga de biriba, cabaça, caxixi e baqueta." \
  "Mestre Bimba (atribuído)" \
  "1940-01-01" \
  "Madeira, cabaça e arame" \
  "160cm x 20cm" \
  "Reserva Técnica C - Instrumentos"

criar_item \
  "Carranca do Rio São Francisco" \
  "Figura de proa de embarcação do Rio São Francisco. Escultura em madeira representando figura protetora." \
  "Mestre Guarany" \
  "1960-01-01" \
  "Escultura em madeira policromada" \
  "80cm x 40cm x 35cm" \
  "Sala de Exposição - Navegação"

echo ""
echo "=========================================="
echo "  COLEÇÃO DE EXEMPLO CRIADA!"
echo "=========================================="
echo ""
echo "  Coleção: Acervo de Demonstração"
echo "  Metadados: 5 campos personalizados"
echo "  Itens: 5 peças de exemplo"
echo ""
echo "  Acesse o Tainacan para explorar:"
echo "  http://localhost:8080/wp-admin/admin.php?page=tainacan_admin"
echo ""
echo "=========================================="
