#!/bin/bash

# Reset NAT
iptables -t nat -F

# 1. DNAT (Belokkan Tujuan ke IronHills) - INI SUDAH BENAR
iptables -t nat -A PREROUTING -s 10.91.1.194 -d 10.91.1.202 -p tcp --dport 80 -j DNAT --to-destination 10.91.1.218

# 2. SNAT (Samarkan Pengirim jadi IP Wilderland) - INI TAMBAHAN PENTING
# Agar IronHills membalas ke Wilderland dulu (bukan langsung ke Vilya)
# IP eth0 Wilderland = 10.91.1.222
iptables -t nat -A POSTROUTING -s 10.91.1.194 -d 10.91.1.218 -p tcp --dport 80 -j SNAT --to-source 10.91.1.222

# Cek Rules
iptables -t nat -L -v -n