FROM alpine:3.15

RUN apk update && apk upgrade && apk add --no-cache mariadb \
    mariadb-client

COPY tools/configure.sh /tmp/configure.sh

EXPOSE 3306

ENTRYPOINT ["sh", "/tmp/configure.sh"]


