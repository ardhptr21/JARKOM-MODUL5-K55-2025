#!/bin/bash

# 1. Install Nginx & IPTables
grep -qF 'nameserver 10.91.1.195' /etc/resolv.conf || echo 'nameserver 10.91.1.195' >> /etc/resolv.conf
apt-get update
apt-get install nginx iptables -y
echo "Welcome to Palantir" > /var/www/html/index.html
service nginx restart

# 2. Reset Firewall
iptables -F
iptables -X

# --- ATURAN AKSES ---

# Rule ELF (Gilgalad & Cirdan): 07.00 - 15.00
# Subnet: 10.91.1.0/25
iptables -A INPUT -s 10.91.1.0/25 -p tcp --dport 80 -m time --timestart 07:00 --timestop 15:00 -j ACCEPT

# Rule MANUSIA (Elendil & Isildur): 17.00 - 23.00
# Subnet: 10.91.0.0/24
iptables -A INPUT -s 10.91.0.0/24 -p tcp --dport 80 -m time --timestart 17:00 --timestop 23:00 -j ACCEPT

# Blokir sisa akses web
iptables -A INPUT -p tcp --dport 80 -j DROP

# Cek Rules
iptables -L -v