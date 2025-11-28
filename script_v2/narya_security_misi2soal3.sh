#!/bin/bash

# IMPORTANT NOTE:
# Tolong install ini dlu di Vilya dan Elendil buat test validasi aja

apt-get update
apt-get install netcat-openbsd -y

# ======================================================================================


# Install iptables & netcat untuk testing
apt-get update
apt-get install iptables netcat-openbsd -y

# Bersihkan rule lama
iptables -F
iptables -X

# --- RULE 1: Izinkan Vilya akses Port 53 (DNS) ---
iptables -A INPUT -s 10.91.1.194 -p udp --dport 53 -j ACCEPT
iptables -A INPUT -s 10.91.1.194 -p tcp --dport 53 -j ACCEPT

# --- RULE 2: Blokir akses Port 53 dari IP lain ---
iptables -A INPUT -p udp --dport 53 -j DROP
iptables -A INPUT -p tcp --dport 53 -j DROP

# Cek Rules
iptables -L -v

# ======================================================================================

# IMPORTANT NOTE:
# Jalanin di atas dlu, baru "nc -z -v 10.91.1.195 53" ke Vilya (sukses) dan Elendil(Gagal). 
# Kalau sudah aman bisa jalanin yang bawah buat hapus aturan
iptables -F



