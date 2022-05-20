FROM alpine

RUN apk update && apk upgrade && apk add --no-cache mariadb \
    mariadb-client

COPY tools/configure.sh /temp/configure.sh

EXPOSE 3306

LABEL description="MariaDB Server"

HEALTHCHECK --start-period=5m \
  CMD mariadb -e 'SELECT @@datadir;' || exit 1

ENTRYPOINT ["sh","./configure.sh";]


