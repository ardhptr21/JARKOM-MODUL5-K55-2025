#!/bin/bash

# 1. Paksa DNS Google dulu (Agar apt update lancar & Ping Google Reply)
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# 2. Install Web Server (Misi 1 No 4)
apt update
apt install nginx -y

# 3. Buat Halaman Web
echo "<h1>INI ADALAH PALANTIR</h1>" > /var/www/html/index.html
service nginx restart

# 4. Balikkan DNS ke Narya (Agar domain arda.local terbaca)
echo "nameserver 10.91.1.195" > /etc/resolv.conf