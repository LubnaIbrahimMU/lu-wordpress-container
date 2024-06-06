# Use an official PHP image with Apache as the base image
FROM php:7.4-apache

# Install dependencies including git
RUN apt-get update && apt-get install -y \
    git \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set the working directory
WORKDIR /var/www/html

# Clone the WordPress repository
# RUN git clone https://github.com/WordPress/WordPress.git .



# Download WordPress
RUN curl -o wordpress.tar.gz https://wordpress.org/latest.tar.gz \
    && tar -xzf wordpress.tar.gz --strip-components=1 \
    && rm wordpress.tar.gz

# Set environment variables for MySQL
ENV WORDPRESS_DB_HOST=db:3306
ENV WORDPRESS_DB_USER=wordpressuser
ENV WORDPRESS_DB_PASSWORD=wordpresspassword
ENV WORDPRESS_DB_NAME=wordpress

# Expose port 80
EXPOSE 80

# Copy the entrypoint script into the image
COPY docker-entrypoint.sh /usr/local/bin/

# Make the entrypoint script executable
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Set the entrypoint script
ENTRYPOINT ["docker-entrypoint.sh"]

# Start Apache in the foreground
CMD ["apache2-foreground"]
