#!/bin/bash
# ===========================================
# Script de Configuração do Tainacan
# Executado dentro do container WordPress
# ===========================================

# Aguarda o WordPress estar pronto
echo "Aguardando WordPress iniciar..."
sleep 10

# Espera o wp-config.php existir
while [ ! -f /var/www/html/wp-config.php ]; do
  echo "Aguardando wp-config.php..."
  sleep 5
done

echo "wp-config.php encontrado!"
sleep 5

cd /var/www/html

# Tenta instalar/verificar WordPress com retry
MAX_TRIES=30
TRIES=0

while [ $TRIES -lt $MAX_TRIES ]; do
  if wp core is-installed --allow-root 2>/dev/null; then
    echo "WordPress já está instalado."
    break
  fi

  TRIES=$((TRIES + 1))
  echo "Tentativa $TRIES/$MAX_TRIES - Instalando WordPress..."

  wp core install \
    --url="http://localhost:8080" \
    --title="Tainacan - Ambiente de Aprendizado" \
    --admin_user="admin" \
    --admin_password="tainacan123" \
    --admin_email="admin@exemplo.com.br" \
    --locale="pt_BR" \
    --allow-root 2>&1

  if [ $? -eq 0 ]; then
    echo "WordPress instalado com sucesso!"
    break
  fi

  echo "  aguardando banco de dados..."
  sleep 5
done

# Verifica se conseguiu instalar
if ! wp core is-installed --allow-root 2>/dev/null; then
  echo "ERRO: Não foi possível instalar o WordPress."
  exit 1
fi

# Configura idioma
echo "Configurando idioma pt_BR..."
wp language core install pt_BR --allow-root 2>/dev/null || true
wp site switch-language pt_BR --allow-root 2>/dev/null || true

# Configura timezone e formatos brasileiros
echo "Configurando timezone e formato de data brasileiro..."
wp option update timezone_string "America/Sao_Paulo" --allow-root
wp option update date_format "d/m/Y" --allow-root
wp option update time_format "H:i" --allow-root

# Instala Tainacan
if ! wp plugin is-installed tainacan --allow-root 2>/dev/null; then
  echo "Instalando e ativando Tainacan..."
  wp plugin install tainacan --activate --allow-root
elif ! wp plugin is-active tainacan --allow-root 2>/dev/null; then
  echo "Ativando Tainacan..."
  wp plugin activate tainacan --allow-root
else
  echo "Tainacan já está instalado e ativo."
fi

# Configura permalinks
echo "Configurando permalinks..."
wp rewrite structure '/%postname%/' --allow-root
wp rewrite flush --allow-root

# Remove plugins padrão
echo "Removendo plugins desnecessários..."
wp plugin delete hello --allow-root 2>/dev/null || true
wp plugin delete akismet --allow-root 2>/dev/null || true

# Remove temas antigos
echo "Removendo temas desnecessários..."
wp theme delete twentytwentytwo --allow-root 2>/dev/null || true
wp theme delete twentytwentyone --allow-root 2>/dev/null || true

echo ""
echo "=========================================="
echo "  INSTALAÇÃO CONCLUÍDA COM SUCESSO!"
echo "=========================================="
echo ""
echo "  WordPress + Tainacan está pronto!"
echo ""
echo "  Acesse: http://localhost:8080"
echo "  Admin:  http://localhost:8080/wp-admin"
echo ""
echo "  Usuário: admin"
echo "  Senha:   tainacan123"
echo ""
echo "=========================================="
