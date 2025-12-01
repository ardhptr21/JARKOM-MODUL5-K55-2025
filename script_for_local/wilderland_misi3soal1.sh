#!/bin/bash
# Misi 3: Isolasi Total Khamul (The Jail of Barad-dûr)

# 1. Sandwich DNS (Standard Procedure)
grep -qF 'nameserver 8.8.8.8' /etc/resolv.conf || echo 'nameserver 8.8.8.8' >> /etc/resolv.conf
apt-get update
apt-get install iptables netcat-openbsd -y

# 2. Definisi Subnet (Biar tidak salah tembak)
# Khamul (TARGET) : 10.91.1.200/29
# Durin (AMAN)    : 10.91.1.128/26

# 3. Konfigurasi Firewall (Filter Table)
# Kita Flush filter table untuk menghapus sisa konfigurasi lama, 
# TAPI biarkan NAT table (Misi 2 No 8) apa adanya atau dihapus sesuai kebutuhan.
# Di sini kita asumsikan isolasi total, jadi kita fokus Block.
iptables -F

# --- RULE UTAMA: BLOCK KHAMUL ---
# Menggunakan -I (Insert) agar aturan ini ditaruh PALING ATAS (Prioritas Tertinggi).

# Blokir paket DARI Khamul (Outgoing)
iptables -I FORWARD -s 10.91.1.200/29 -j DROP

# Blokir paket MENUJU Khamul (Incoming)
iptables -I FORWARD -d 10.91.1.200/29 -j DROP

# Log untuk membuktikan pemblokiran (Opsional, biar keren di laporan)
iptables -I FORWARD -s 10.91.1.200/29 -j LOG --log-prefix "KHAMUL_BLOCKED_OUT: "
iptables -I FORWARD -d 10.91.1.200/29 -j LOG --log-prefix "KHAMUL_BLOCKED_IN: "

# 4. Cek Rules
iptables -L FORWARD -v -n

# 5. Restore DNS
echo "nameserver 10.91.1.195" > /etc/resolv.conf