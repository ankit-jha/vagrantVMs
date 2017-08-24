#! /usr/bin/env bash

# Variables
DBUSER=root
DBPASSWD=root
STATIC_IP=192.168.33.10

echo -e "\n--- Run Updates ---\n"
apt-get update
apt-get -y upgrade

# MySQL setup for development purposes ONLY
echo -e "\n--- Install MySQL specific packages and settings ---\n"

debconf-set-selections <<< "mysql-server mysql-server/root_password password $DBPASSWD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $DBPASSWD"
apt-get -y install mysql-server

mysql -u $DBUSER -p $DBPASSWD  -e "create user '$DBUSER'@'$STATIC_IP' identified by '$DBPASSWD'; grant all privileges on *.* to '$DBUSER'@'%' with grant option; flush privileges;"

echo -e "\n--- Setup Complete ---\n"
