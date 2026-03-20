#!/bin/bash
set -e

# Copy .env if not present
if [ ! -f /var/www/.env ]; then
    cp /var/www/.env.docker /var/www/.env
fi

# Generate application key if not set
php artisan key:generate --force

# Wait for MySQL to be ready
echo "Waiting for MySQL..."
until php -r "new PDO('mysql:host=${DB_HOST:-mysql};port=${DB_PORT:-3306};dbname=${DB_DATABASE:-finance_payment}', '${DB_USERNAME:-root}', '${DB_PASSWORD:-secret}');" 2>/dev/null; do
    sleep 2
    echo "Waiting for MySQL..."
done
echo "MySQL is ready."

# Run migrations
php artisan migrate --force

# Set proper permissions
chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache
chmod -R 775 /var/www/storage /var/www/bootstrap/cache

# Start PHP built-in server
exec php -S 0.0.0.0:8000 -t public
