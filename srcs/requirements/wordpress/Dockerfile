FROM	alpine:3.15
RUN	apk update && apk upgrade && apk add --no-cache \
	mariadb-client \
	wget \
	tar \
	vim \
	php7 php7-cli php7-fpm php7-json \
	php7-common php7-mysqli php7-zip \
	php7-gd php7-mbstring php7-xml php-phar\
	php7-xml php7-pear php7-openssl php7-bcmath 

# Php config
RUN	adduser -S nginx &&	addgroup -S nginx
COPY	tools/php-fpm.conf /etc/php7/php-fpm.conf
COPY	tools/www.conf /etc/php7/php-fpm.d/www.conf
RUN     mkdir -p /var/www/html/
RUN 	chmod 777 /var/www/html/

#Download and Setup Worpress-cli https://wp-cli.org/fr/
RUN 	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN	php wp-cli.phar --info
RUN 	chmod +x wp-cli.phar
RUN	mv wp-cli.phar /usr/bin/wp
RUN	chown -R nginx:nginx /usr/bin/wp


# Install Worpress via Worpress-cli
#RUN	wp core download --path=/var/www/html/

# Move config Files
#COPY	tools/wp-config.php /var/www/html/wp-config.php
#COPY 	tools/index.html /var/www/html/
#COPY	/tools/start.sh .
#EXPOSE	9000

#ENTRYPOINT [ "sh", "start.sh" ]

WORKDIR /var/www/html/wordpress

COPY tools/configure.sh /tmp/configure.sh
ENTRYPOINT [ "sh", "/tmp/configure.sh" ]
