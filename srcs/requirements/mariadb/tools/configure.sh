#! /bin/bash
service mariadb start;
sudo mysql -u root -p
CREATE DATABASE $MARIADB_DATABASE;
CREATE USER $MARIADB_MYSQL_LOCALHOST_USER@'localhost' IDENTIFIED BY $MARIADB_PASSWORD;
GRANT ALL PRIVILEGES ON $MARIADB_DATABASE.* TO $MARIADB_MYSQL_LOCALHOST_USER@'localhost';
FLUSH PRIVILEGES;
EOF