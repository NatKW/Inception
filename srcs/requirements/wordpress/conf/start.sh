chmod -R 755 /var/www/html
chown nginx:nginx /var/www/html

service php7-fpm start
service php7-fpm stop

php-fpm7 -R -F
