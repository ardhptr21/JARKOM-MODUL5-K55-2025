#!/bin/bash

# 1. PAKSA DNS KE GOOGLE DULU (Agar apt update jalan)
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# 2. Nyalakan IP Forwarding (Wajib untuk Router!)
sysctl -w net.ipv4.ip_forward=1

# 3. Update & Install Relay
apt update
apt install isc-dhcp-relay -y

# 4. Konfigurasi Relay
# SERVERS: IP Vilya
# INTERFACES: eth0 (arah Osgiliath), eth1 (arah IronHills), eth2 (arah Wilderland)
cat << EOF > /etc/default/isc-dhcp-relay
SERVERS="10.91.1.194"
INTERFACESv4="eth0 eth1 eth2"
EOF

# 5. Restart Service
service isc-dhcp-relay restart

# 6. KEMBALIKAN DNS KE NARYA (Sesuai Soal)
echo "nameserver 10.91.1.195" > /etc/resolv.conf