#!/bin/bash

# --- SANDWICH START ---
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# 1. Update & Install
apt update
apt install isc-dhcp-server -y

# 2. Config Interface
cat << EOF > /etc/default/isc-dhcp-server
INTERFACESv4="eth0"
EOF

# 3. Config Subnet (LENGKAP)
cat << EOF > /etc/dhcp/dhcpd.conf
default-lease-time 600;
max-lease-time 7200;

# Subnet A2 (Vilya sendiri)
subnet 10.91.1.192 netmask 255.255.255.248 {
}

# Subnet A9: Elendil & Isildur (Via Minastir)
subnet 10.91.0.0 netmask 255.255.255.0 {
    range 10.91.0.2 10.91.0.200;
    option routers 10.91.0.1;
    option broadcast-address 10.91.0.255;
    option domain-name-servers 10.91.1.195;
    option domain-name "arda.local";
}

# Subnet A13: Cirdan & Gilgalad (Via AnduinBanks)
subnet 10.91.1.0 netmask 255.255.255.128 {
    range 10.91.1.2 10.91.1.100;
    option routers 10.91.1.1;
    option broadcast-address 10.91.1.127;
    option domain-name-servers 10.91.1.195;
}

# Subnet A6: Durin (Via Wilderland)
subnet 10.91.1.128 netmask 255.255.255.192 {
    range 10.91.1.130 10.91.1.179;
    option routers 10.91.1.129;
    option broadcast-address 10.91.1.191;
    option domain-name-servers 10.91.1.195;
}

# Subnet A7: Khamul (Via Wilderland)
subnet 10.91.1.200 netmask 255.255.255.248 {
    range 10.91.1.202 10.91.1.206;
    option routers 10.91.1.201;
    option broadcast-address 10.91.1.207;
    option domain-name-servers 10.91.1.195;
}
EOF

# 4. Restart Server
service isc-dhcp-server restart
service isc-dhcp-server status

# --- SANDWICH END ---
echo "nameserver 10.91.1.195" > /etc/resolv.conf