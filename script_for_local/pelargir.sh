#!/bin/bash

# --- SANDWICH START ---
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# 1. Nyalakan Routing (KUNCI AGAR PAKET LEWAT)
sysctl -w net.ipv4.ip_forward=1

# 2. Install Tools Dasar (Optional, untuk debug nanti)
apt update
apt install netcat dnsutils -y

# --- SANDWICH END ---
echo "nameserver 10.91.1.195" > /etc/resolv.conf