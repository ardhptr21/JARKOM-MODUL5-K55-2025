#!/bin/bash
# Revisi Misi 2 No 7: Hard Limit Connection

# 1. Reset
iptables -F
iptables -X

# 2. Set Waktu ke SABTU
date -s "2023-11-04 10:00:00"

# 3. RULE UTAMA (LIMIT) - LEBIH KETAT
# Kita pakai limit 2 (bukan 3) untuk testing agar lebih mudah gagal.
# Dan kita reject packet SYN baru.
iptables -A INPUT -p tcp --syn --dport 80 -m connlimit --connlimit-above 2 -j REJECT --reject-with tcp-reset

# 4. RULE AKSES (Whitelist IP)
iptables -A INPUT -s 10.91.0.0/24 -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -s 10.91.1.128/26 -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -s 10.91.1.200/29 -p tcp --dport 80 -j ACCEPT

# 5. Default Drop
iptables -A INPUT -p tcp --dport 80 -j DROP

# 6. Cek
iptables -L -v