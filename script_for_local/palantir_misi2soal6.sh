#!/bin/bash

apt-get update
apt-get install iptables rsyslog -y

# 1. Bersihkan semua aturan lama
iptables -F
iptables -X

# 2. Buat Chain khusus logging
iptables -N PORT_SCAN
iptables -A PORT_SCAN -j LOG --log-prefix "PORT_SCAN_DETECTED " --log-level 4
iptables -A PORT_SCAN -j DROP

# 3. RULE UTAMA (Urutan Sangat Penting!)

# A. Cek apakah IP ini SUDAH di-blacklist? Jika ya, langsung DROP (Update timer 20 detiknya)
# Ini adalah "Tembok Benteng". Jika nmap menyerang, counter di baris ini yang akan meledak naik.
iptables -A INPUT -m recent --name port_scanners --update --seconds 20 --reap -j DROP

# B. Jika koneksi BARU (NEW), catat IP-nya ke daftar pengamatan
iptables -A INPUT -m state --state NEW -m recent --name port_scanners --set

# C. Cek apakah IP ini melakukan koneksi BARU lebih dari 15 kali dalam 20 detik?
# Jika ya, lempar ke chain PORT_SCAN (untuk dicatat log dan di-DROP)
iptables -A INPUT -m state --state NEW -m recent --name port_scanners --rcheck --seconds 20 --hitcount 15 -j PORT_SCAN

# D. Izinkan akses normal (Hanya bisa lewat jika belum di-blacklist di poin A)
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p icmp -j ACCEPT

# E. Blokir sisa paket sampah lainnya
iptables -A INPUT -j DROP

# 4. Tampilkan status awal (Harusnya semua 0)
iptables -L INPUT -v -n