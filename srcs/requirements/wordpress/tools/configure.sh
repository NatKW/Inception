
#!/bin/sh

# wait for mysql
while ! mariadb -h mariadb -u$MARIADB_USER -p$MARIADB_PASSWORD $MARIADB_DATABASE &>/dev/null; do

    sleep 3
done

if [ ! -f "/var/www/html/index.php" ]; then

    # static website
    #mv /tmp/index.html /var/www/html/index.html

    wp core download --allow-root
    wp config create --dbname=$MARIADB_DATABASE --dbuser=$MARIADB_USER --dbpass=$MARIADB_PASSWORD --dbhost=mariadb --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root
    wp core install --url=$DOMAIN_NAME --title=$WORDPRESS_DB_TITLE --admin_user=$WORDPRESS_DB_ADMIN --admin_password=$WORDPRESS_DB_ADMIN_PWD --admin_email=$WORDPRESS_DB_ADMIN_EMAIL --skip-email --allow-root
    wp user create $W_USER $W_EMAIL --role=author --user_pass=$W_PWD --allow-root
    wp user create paul ddalee@hotmail.com --role=author --user_pass=123123 --allow-root
    wp theme install  twenty sixteen --activate --allow-root
    wp theme update twenty sixteen --allow-root
    wp plugin update --all --allow-root

fi

echo "Wordpress started on :9000"
/usr/sbin/php-fpm7 -F -R
