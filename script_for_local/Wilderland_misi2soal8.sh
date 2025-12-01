#!/bin/bash
# Misi 2 No 8: The Black Magic Redirect (DNAT)
# Tanpa instalasi, langsung ke inti konfigurasi.
apt-get update
apt-get install iptables netcat-openbsd -y

# Revisi Misi 2 No 8: DNAT + SNAT (Fix Routing)

# 1. Pastikan IP Forwarding Aktif
sysctl -w net.ipv4.ip_forward=1

# 2. Reset NAT
iptables -t nat -F
iptables -t nat -X

# 3. RULE 1: DNAT (Sihir Pembelok Tujuan)
# Paket dari Vilya yg mau ke Khamul, belokkan ke IronHills
iptables -t nat -A PREROUTING -s 10.91.1.194 -d 10.91.1.202 -j DNAT --to-destination 10.91.1.218

# 4. RULE 2: SNAT (Penyamaran Pengirim - INI KUNCINYA)
# Paket yang menuju IronHills (hasil belokan tadi), ubah pengirimnya jadi IP Wilderland (10.91.1.222).
# Agar IronHills membalas ke Wilderland, bukan langsung ke Vilya.
iptables -t nat -A POSTROUTING -d 10.91.1.218 -j SNAT --to-source 10.91.1.222

# 5. Cek Rules
iptables -t nat -L -v -n


# === engga muncul saat validasi? ===
# coba jalanin ini di terminal IronHills:
iptables -F
iptables -X
# Pastikan bersih
iptables -L -v
# Policy harus ACCEPT semua

