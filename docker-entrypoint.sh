#!/bin/bash
set -e

# Check if wp-config.php exists
if [ ! -f wp-config.php ]; then
  # Copy the sample config file to wp-config.php
  cp wp-config-sample.php wp-config.php

  # Update database settings in wp-config.php
  sed -i "s/database_name_here/$WORDPRESS_DB_NAME/" wp-config.php
  sed -i "s/username_here/$WORDPRESS_DB_USER/" wp-config.php
  sed -i "s/password_here/$WORDPRESS_DB_PASSWORD/" wp-config.php
  sed -i "s/localhost/$WORDPRESS_DB_HOST/" wp-config.php
fi

# Run the main container command
exec "$@"
