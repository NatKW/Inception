FROM alpine:3.15

RUN apk update && apk upgrade && apk add --no-cache \
    nginx \
    openssl

# install ssl
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
        -out /etc/nginx/ssl/nade-la-.42.fr.crt \
        -keyout /etc/nginx/ssl/nade-la-.42.fr.key \
        -subj "/C=Fr/ST=IledeFrance/L=Paris/O=42 School/CN=nade-la-.42.fr"
# configurer nginx
RUN mkdir -p /var/www/html
COPY conf/nginx.conf /etc/nginx/http.d/default.conf

#demarrer nginx
ENTRYPOINT ["nginx", "-g", "daemon off;"]






