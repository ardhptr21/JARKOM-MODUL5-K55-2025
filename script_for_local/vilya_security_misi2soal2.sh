#!/bin/bash

# Pastikan iptables terinstall
apt-get update
apt-get install iptables -y
apt-get update
apt-get install netcat-openbsd -y

# Bersihkan aturan lama (Flush) agar tidak tumpang tindih
iptables -F
iptables -X

# ATURAN UTAMA:
# Blokir semua paket ICMP tipe "Echo Request" (Ping) yang MASUK ke Vilya
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP

# (Optional) Pastikan paket balasan untuk Vilya tetap diizinkan
# Biasanya default policy ACCEPT, tapi ini untuk memastikan keamanan koneksi Vilya sendiri
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Tampilkan aturan yang sudah dibuat
iptables -L -v




