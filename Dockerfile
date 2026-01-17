# Dockerfile para WordPress + Tainacan
# Ambiente de aprendizado para museólogos

FROM wordpress:php8.2-apache

LABEL maintainer="Ambiente de Aprendizado Tainacan"
LABEL description="WordPress com extensões PHP otimizadas para Tainacan"

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    libmagickwand-dev \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libwebp-dev \
    ghostscript \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Configurar extensões GD com suporte a formatos de imagem
RUN docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg \
    --with-webp

# Instalar extensões PHP necessárias para Tainacan
RUN docker-php-ext-install \
    gd \
    zip \
    exif \
    opcache

# Instalar ImageMagick via PECL (para thumbnails de PDF)
# Usa || true para ignorar se já estiver instalado
RUN pecl install imagick || true \
    && docker-php-ext-enable imagick || true

# Configurar política do ImageMagick para permitir PDFs
RUN if [ -f /etc/ImageMagick-6/policy.xml ]; then \
    sed -i 's/rights="none" pattern="PDF"/rights="read|write" pattern="PDF"/' /etc/ImageMagick-6/policy.xml; \
    fi

# Habilitar mod_rewrite para permalinks bonitos
RUN a2enmod rewrite

# Instalar WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Copiar script de setup
COPY scripts/setup.sh /usr/local/bin/setup-tainacan.sh
RUN chmod +x /usr/local/bin/setup-tainacan.sh

# Configurar permissões corretas
RUN chown -R www-data:www-data /var/www/html

# Expor porta 80
EXPOSE 80

# Usar entrypoint padrão do WordPress
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
