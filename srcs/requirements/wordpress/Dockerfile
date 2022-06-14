FROM	alpine:3.15
RUN	apk update && apk upgrade && apk add --no-cache \
	mariadb-client \
	wget \
	vim \
	tar \
	php7 php7-cli php7-fpm php7-json \
	php7-common php7-mysqli php7-zip \
	php7-gd php7-mbstring php7-xml \
	php7-xml php7-pear php7-openssl php7-bcmath 


RUN	adduser -S nginx &&	addgroup -S nginx
COPY	tools/php-fpm.conf /etc/php7/php-fpm.conf
COPY	tools/www.conf /etc/php7/php-fpm.d/www.conf

RUN     mkdir -p /var/www/html/
RUN 	chmod 777 /var/www/html/
RUN 	wget http://wordpress.org/latest.tar.gz 
RUN	tar -xzvf latest.tar.gz
RUN	rm latest.tar.gz
RUN 	cp -R /wordpress /var/www/html/
COPY	tools/wp-config.php /var/www/html/wp-config.php
COPY 	tools/index.html /var/www/html/
COPY	/tools/start.sh .

EXPOSE	9000

ENTRYPOINT [ "sh", "start.sh" ]
