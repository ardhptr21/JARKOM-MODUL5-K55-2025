#!/bin/bash

# Pastikan Nginx, IPTables, dan Apache Benchmark terinstall
grep -qF 'nameserver 10.91.1.195' /etc/resolv.conf || echo 'nameserver 10.91.1.195' >> /etc/resolv.conf
apt-get update
apt-get install nginx iptables apache2-utils -y
service nginx restart

# Set Waktu ke Sabtu (Sesuai Soal agar akses diizinkan dulu secara waktu)
date -s "2023-11-04 10:00:00"   

# Reset Firewall
iptables -F
iptables -X

# --- RULE SOAL 7: Batasi Koneksi Maksimal 3 per IP ---
# Jika satu IP membuka koneksi ke-4 (atau lebih) secara bersamaan, paketnya di-DROP
iptables -A INPUT -p tcp --syn --dport 80 -m connlimit --connlimit-above 3 -j DROP

# Izinkan akses web normal (jika koneksi <= 3)
iptables -A INPUT -p tcp --dport 80 -j ACCEPT

# Izinkan SSH/Ping (biar tidak terkunci)
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p icmp -j ACCEPT

# Cek Rules
iptables -L -v



# Ngebug? coba Reset couter
# iptables -Z
# iptables -L -v -n