FROM	alpine:3.13
RUN	apk update && apk upgrade && apk add --no-cache \
	curl \
	tar \
	mariadb-client \
	vim

# Install PHP and extensions.
RUN         apt-get -y install php7.3-fpm php7.3-mysqli

# Php config
COPY        conf/php-fpm.conf /etc/php/7.3/fpm/php-fpm.conf
COPY        conf/yolo.conf /etc/php/7.3/fpm/yolo.conf
# COPY        conf/php.ini /etc/php/7.3/fpm/conf.d/custom.ini
RUN         mkdir -p /run/php/

# Users config
RUN         useradd -ms /bin/bash nginx
RUN         usermod -a -G www www
RUN			mkdir -p /var/www
RUN         chown -R www:www /var/www

# Users config
RUN         useradd -ms /bin/bash nade-la-
RUN         usermod -a -G sudo nade-la-
RUN         useradd user42
RUN         usermod -a -G users user42

# Install Wordpress
# RUN			mkdir -p /var/www/wordpress
# RUN			mkdir /srcs/
# WORKDIR		/srcs/
# RUN         curl https://wordpress.org/latest.tar.gz -o latest.tar.gz
# RUN         tar -xzvf latest.tar.gz
# RUN			mv ./wordpress/ /var/www/
# WORKDIR		/
# COPY		./conf/index.html /var/www/
# RUN			rm -rf /srcs/

# Install Worpress-cli
# RUN         curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# RUN         mv wp-cli.phar /usr/local/bin/wp
# RUN         chmod +x /usr/local/bin/wp
# RUN         chown -R www:www /usr/local/bin/wp
# RUN         wp --path=/var/www core download --allow-root
# # RUN         cat /var/www/wp-config.php
# RUN         rm -rf /var/www/wp-config.php
# # wp config create --dbname=wordpress --dbuser=gozsertt --dbpass=gozserttpass --dbhost=mariadb:3306 --dbcharset=utf8 --path=/var/www/ --allow-root --skip-check
# RUN         wp config create --dbname=${WP_DB_NAME} --dbuser=${WP_DB_ADMIN} --dbpass=${WP_DB_ADMIN_PASSWORD} --dbhost=${WP_DB_HOST} --dbcharset=utf8 --path=/var/www/ --allow-root --skip-check
# # RUN         wp --path=/var/www core config --dbhost=${WP_DB_HOST} --dbname=${WP_DB_NAME} --dbuser=${WP_DB_ADMIN} --dbpass=${WP_DB_ADMIN_PASSWORD} --allow-root
# # wp core install --url=yourwebsite.com --title="Your Blog Title" --admin_name=wordpress_admin --admin_password=4Long&Strong1 --admin_email=you@example.com
# RUN         chmod 644 /var/www/wp-config.php
# RUN         wp --path=/var/www core install --url=${DOMAIN_NAME} --title=${PROJECT_NAME} --admin_name=${WP_DB_ADMIN} --admin_password=${WP_DB_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL} --skip-email --allow-root
# RUN         wp --path=/var/www user create /var/www/ gozsertt gozsertt@42.fr --user_pass=gozserttpass --role="administrator" --allow-root
# RUN         wp --path=/var/www user create /var/www/ robert robert@gmail.com --user_pass=robertpass --role="editor" --allow-root
# RUN         wp --path=/var/www plugin install redis-cache --activate --allow-root
# RUN         wp --path=/var/www plugin update --all --allow-root

# # RUN           service mysql start
# COPY            conf/index.php index.php

# ADD         /tools/entry-point.sh /scripts/
# RUN         chmod +x /scripts/entry-point.sh
#XXXXXXX
#Download and Setup Worpress-cli
RUN         curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN         php wp-cli.phar --info
RUN         chmod +x wp-cli.phar
RUN         mv wp-cli.phar /usr/local/bin/wp
RUN         chown -R www:www /usr/local/bin/wp

# #Install Worpress via Worpress-cli
WORKDIR     /var/www/html/wordpress
RUN         rm -rf /var/www/wp-config.php
RUN         wp core download --allow-root
RUN         wp config create --dbname=${WORDPRESS_DB_NAME} --dbuser=${WORDPRESS_DB_ADMIN} --dbpass=${WP_DB_ADMIN_PASSWORD} --dbhost=mariadb --dbcharset=utf8 --path=/var/www/ --allow-root --skip-check
# RUN         wp core install --url=${DOMAIN_NAME} --title=${PROJECT_NAME} --admin_name=${WP_DB_ADMIN} --admin_password=${WP_DB_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL} --skip-email --allow-root
# RUN         wp --path=/var/www core config --dbhost=${WP_DB_HOST} --dbname=mariadb --dbuser=${WP_DB_ADMIN} --dbpass=${WP_DB_ADMIN_PASSWORD} --allow-root

WORKDIR     /var/www/html/wordpress

# Warning: mysqli_real_connect(): (HY000/1130): Host 'wordpress.srcs_backend' is not allowed to connect to this MariaDB server in /var/www/wp-includes/wp-db.php on line 1753
# Host 'wordpress.srcs_backend' is not allowed to connect to this MariaDB server

# Error establishing a database connection



# RUN             wp core config --dbname=wordpress --dbuser=gozsertt --dbpass=gozserttpass --dbhost=3306:3306 --dbprefix=wp_ --allow-root

# # RUN           wp --path=/var/www core config --dbhost=${WP_DB_HOST} --dbname=${WP_DB_NAME} --dbuser=${WP_DB_ADMIN} --dbpass=${WP_DB_ADMIN_PASSWORD} --allow-root
# RUN           wp core install --url="gozsertt.42.fr" --title="Inception" --admin_user="gozsertt" --admin_password="gozserttpass" --admin_email="gozsertt@student.42.fr" --allow-root
# # RUN         wp --path=/var/www core install --url=${DOMAIN_NAME} --title=${PROJECT_NAME} --admin_name=${WP_DB_ADMIN} --admin_password=${WP_DB_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL} --skip-email --allow-root

# RUN             mkdir -p /var/log/php7
# RUN             touch /var/log/php7/www.access.log

# Install Redis
# RUN         wp --path=/var/www redis enable --allow-root

# Expose the port 9000
EXPOSE      9000

ENTRYPOINT /usr/sbin/php-fpm7.3 -F -R

COPY tools/configure.sh /tmp/configure.sh

ENTRYPOINT [ "sh", "/tmp/configure.sh" ]
