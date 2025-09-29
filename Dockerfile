FROM php:8.1

WORKDIR /app

RUN apt-get update && apt-get install -y \
  libzip-dev \
  zip \
  git 

# Install php extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- \
  --install-dir=/usr/bin --filename=composer

COPY . /app

RUN composer install --ignore-platform-reqs

# Convert CRLF -> LF and make it executable
RUN sed -i 's/\r$//' /app/docker-startup.sh && chmod +x /app/docker-startup.sh

ENTRYPOINT [ "/app/docker-startup.sh" ]

