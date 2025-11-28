# Note important:
# Aku engga jalanin script ironhills.sh yang lama, tapi update dengan menyesuaikan kebutuhan soal

#!/bin/bash

# 1. Pastikan Nginx terinstall (Web Server)
# Agar saat dites curl nanti ada responnya (kalau tidak diblokir)
grep -qF 'nameserver 10.91.1.195' /etc/resolv.conf || echo 'nameserver 10.91.1.195' >> /etc/resolv.conf
apt-get update
apt-get install nginx iptables -y
echo "Welcome to IronHills" > /var/www/html/index.html
service nginx restart

# 2. Set Waktu ke RABU (Simulasi AWAL)
date -s "2023-11-01 10:00:00"

# 3. Konfigurasi Firewall
iptables -F
iptables -X

# Rule: Izinkan Akses Web (Port 80) HANYA di Sabtu & Minggu
# Dari Durin
iptables -A INPUT -s 10.91.1.128/26 -p tcp --dport 80 -m time --weekdays Sat,Sun -j ACCEPT
# Dari Khamul
iptables -A INPUT -s 10.91.1.200/29 -p tcp --dport 80 -m time --weekdays Sat,Sun -j ACCEPT
# Dari Elendil & Isildur
iptables -A INPUT -s 10.91.0.0/24 -p tcp --dport 80 -m time --weekdays Sat,Sun -j ACCEPT

# Blokir sisanya
iptables -A INPUT -p tcp --dport 80 -j DROP

# Cek status
echo "Waktu Server Saat Ini:"
date
iptables -L -v