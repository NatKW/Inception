
#!/bin/sh

# wait for mysql
while ! mariadb -h$WORDPRESS_DB_HOST -u$WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD $WORDPRESS_DB_NAME &>/dev/null; do
    sleep 3
done

if [ ! -f "/var/www/html/index.php" ]; then

    # static website
    #mv /tmp/index.html /var/www/html/index.html

    wp core download --allow-root
    wp config create --dbname=$WORDPRESS_DB_NAME --dbuser=$WORDPRESS_DB_USER --dbpass=$WORDPRESS_DB_PASSWORD --dbhost=$WORDPRESS_DB_HOST --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
    wp core install --url=$DOMAIN_NAME --title=$WORDPRESS_DB_TITLE --admin_user=$WORDPRESS_DB_ADMIN --admin_password=$WORDPRESS_DB_ADMIN_PWD --admin_email=$WORDPRESS_DB_ADMIN_EMAIL --skip-email --allow-root
    wp user create $WORDPRESS_DB_USER $WORDPRESS_DB_EMAIL --role=author --user_pass=$WORDPRESS_DB_PASSWORD --allow-root
    wp theme install  twenty sixteen --activate --allow-root
    wp theme update twenty sixteen --allow-root
    wp plugin update --all --allow-root

fi

echo "Wordpress started on :9000"
/usr/sbin/php-fpm7 -F -R
