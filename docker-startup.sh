#!/bin/sh
set -e

# wait for db connection if you later use local db
# sleep 10s

echo "Running Laravel setup..."

php artisan key:generate
php artisan migrate --seed || true
php artisan storage:link || true

echo "Starting Laravel server..."
php artisan serve --host=0.0.0.0 --port=8000
