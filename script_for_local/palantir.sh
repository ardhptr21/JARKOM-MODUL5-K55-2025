#!/bin/bash

grep -qF 'nameserver 10.91.1.195' /etc/resolv.conf || echo 'nameserver 10.91.1.195' >> /etc/resolv.conf

apt update
apt install nginx -y

rm -rf /var/www/html/*

echo "Welcome to Palantir" > /var/www/html/index.html

service nginx restart