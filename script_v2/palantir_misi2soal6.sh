#!/bin/bash

# Reset Firewall (Opsional, tapi biar bersih)
# HATI-HATI: Ini akan menghapus rule Soal 5 (Akses Waktu).
# Jika ingin digabung, jangan jalankan baris iptables -F di bawah ini.
# Tapi untuk pengujian Soal 6 saja, sebaiknya di-flush biar jelas.
iptables -F
iptables -X

# Buat Chain baru khusus untuk Scan
iptables -N PORT_SCAN

# --- LOGIKA PORT SCAN PROTECTION ---

# 1. Jika paket masuk ke chain PORT_SCAN:
#    - Catat di Log dengan prefix "PORT_SCAN_DETECTED"
#    - Drop paketnya
iptables -A PORT_SCAN -j LOG --log-prefix "PORT_SCAN_DETECTED "
iptables -A PORT_SCAN -j DROP

# 2. Aturan Utama di INPUT Chain:
#    - Cek apakah IP pengirim sudah ada di daftar 'port_scanners' (blacklist)?
#    - Jika YA, update statusnya (biar durasi blokir diperpanjang) dan DROP paketnya.
iptables -A INPUT -m recent --name port_scanners --update --seconds 20 --reap -j DROP

# 3. Deteksi Scanning Baru:
#    - Jika ada koneksi baru (SYN), tambahkan ke daftar 'port_scanners'.
#    - Jika hit count > 15 dalam 20 detik, lempar ke chain PORT_SCAN (untuk di-log dan di-drop).
iptables -A INPUT -m state --state NEW -m recent --name port_scanners --set
iptables -A INPUT -m state --state NEW -m recent --name port_scanners --rcheck --seconds 20 --hitcount 15 -j PORT_SCAN

# 4. Izinkan akses normal (agar web server tetap bisa diakses kalau tidak nge-scan)
#    (Opsional untuk tes ini, tapi baik untuk praktik)
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p icmp -j ACCEPT

# Cek Rules
iptables -L -v