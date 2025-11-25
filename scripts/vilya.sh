#!/bin/bash

grep -qF 'nameserver 10.91.1.195' /etc/resolv.conf || echo 'nameserver 10.91.1.195' >> /etc/resolv.conf

apt update
apt install isc-dhcp-server -y

cat << EOF > /etc/default/isc-dhcp-server
INTERFACESv4="eth0"
EOF

cat << EOF > /etc/dhcp/dhcpd.conf
# durin
subnet 10.91.1.128 netmask 255.255.255.192 {
  range 10.91.1.130 10.91.1.179;
  option routers 10.91.1.129;
  option broadcast-address 10.91.1.191;
}

# khamul
subnet 10.91.1.200 netmask 255.255.255.248 {
  range 10.91.1.202 10.91.1.206;
  option routers 10.91.1.201;
  option broadcast-address 10.91.1.207;
}

# elendil & isildur
subnet 10.91.0.0 netmask 255.255.255.0 {
  range 10.91.0.2 10.91.0.201;
  range 10.91.0.202 10.91.0.251;
  option routers 10.91.0.1;
  option broadcast-address 10.91.0.255;
}

# gilgalad & cirdan
subnet 10.91.1.0 netmask 255.255.255.128 {
  range 10.91.1.2 10.91.1.101;
  range 10.91.1.102 10.91.1.121;
  option routers 10.91.1.1;
  option broadcast-address 10.91.1.127;
}

subnet 10.91.1.192 netmask 255.255.255.248 {}
EOF

service isc-dhcp-server restart