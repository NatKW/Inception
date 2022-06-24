#!/bin/sh

wp core install --path=/var/www/html --url=$DOMAIN_NAME --title=$WORDPRESS_DB_TITLE --admin_name=$ORDPRESS_DB_ADMIN --admin_password=$WORDPRESS_DB_ADMIN_PWD --admin_email=$WORDPRESS_DB__EMAIL --allow-root --skip-email
php-fpm7 -F -R
