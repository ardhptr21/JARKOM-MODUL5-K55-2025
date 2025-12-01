#!/bin/bash

# --- SANDWICH START ---
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# 1. Nyalakan Routing
sysctl -w net.ipv4.ip_forward=1

# 2. Install Relay
apt update
apt install isc-dhcp-relay -y

# 3. Konfigurasi Relay
# eth0 (Moria), eth1 (Durin), eth2 (Khamul)
cat << EOF > /etc/default/isc-dhcp-relay
SERVERS="10.91.1.194"
INTERFACESv4="eth0 eth1 eth2"
EOF

# 4. Restart Service
service isc-dhcp-relay restart

# --- SANDWICH END ---
echo "nameserver 10.91.1.195" > /etc/resolv.conf