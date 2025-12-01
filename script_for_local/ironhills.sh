#!/bin/bash

# 1. Paksa DNS Google
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# 2. Install Web Server
apt update
apt install nginx -y

# 3. Buat Halaman Web
echo "<h1>INI ADALAH IRONHILLS</h1>" > /var/www/html/index.html
service nginx restart

# 4. Balikkan DNS ke Narya
echo "nameserver 10.91.1.195" > /etc/resolv.conf