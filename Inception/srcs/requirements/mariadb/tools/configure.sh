#! /bin/bash
service mariadb start;

mysql -e

exec /usr/bin/mysqld --user=mysql --console