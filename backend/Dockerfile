# Dockerfile for Laravel Backend
FROM php:8.2-fpm

# Set working directory
WORKDIR /var/www

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    zip \
    unzip \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy composer files first for layer caching
COPY composer.json composer.lock ./

# Install Laravel dependencies (no dev dependencies in production)
RUN composer install --no-interaction --optimize-autoloader --no-dev

# Copy the rest of the application code
COPY . .

# Copy Docker environment file
COPY .env.docker .env.docker

# Copy and set entrypoint
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Give writable permissions to Laravel's storage and cache
RUN chown -R www-data:www-data /var/www \
    && chmod -R 775 /var/www/storage \
    && chmod -R 775 /var/www/bootstrap/cache

# Expose the port Laravel runs on
EXPOSE 8000

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
