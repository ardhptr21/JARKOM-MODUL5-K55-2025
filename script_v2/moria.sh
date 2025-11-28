#!/bin/bash

# Arahkan DNS ke Narya (atau Google sementara jika Narya belum siap)
grep -qF 'nameserver 10.91.1.195' /etc/resolv.conf || echo 'nameserver 10.91.1.195' >> /etc/resolv.conf

# Update dan Install DHCP Relay
apt update
apt install isc-dhcp-relay -y

# Konfigurasi Interface DHCP Relay
# SERVERS: IP Vilya (DHCP Server)
# INTERFACESv4: Semua interface yang terlibat (eth0=uplink ke Osgiliath, eth1=IronHills, eth2=Wilderland)
cat << EOF > /etc/default/isc-dhcp-relay
SERVERS="10.91.1.194"
INTERFACESv4="eth0 eth1 eth2"
EOF

# Restart Service
service isc-dhcp-relay restart