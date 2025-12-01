#!/bin/bash

# --- SANDWICH START: Paksa DNS Google ---
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# 1. Nyalakan Routing (Wajib)
sysctl -w net.ipv4.ip_forward=1

# 2. Install Relay
apt update
apt install isc-dhcp-relay -y

# 3. Konfigurasi Relay
# SERVERS: IP Vilya
# INTERFACES: eth0 (Uplink Osgiliath), eth1 (Client A9), eth2 (Downlink Pelargir)
cat << EOF > /etc/default/isc-dhcp-relay
SERVERS="10.91.1.194"
INTERFACESv4="eth0 eth1 eth2"
EOF

# 4. Restart Service
service isc-dhcp-relay restart

# --- SANDWICH END: Balik ke Narya ---
echo "nameserver 10.91.1.195" > /etc/resolv.conf