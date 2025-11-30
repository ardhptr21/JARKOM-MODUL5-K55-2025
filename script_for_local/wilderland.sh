#!/bin/bash

grep -qF 'nameserver 10.91.1.195' /etc/resolv.conf || echo 'nameserver 10.91.1.195' >> /etc/resolv.conf

apt update
apt install isc-dhcp-relay -y

cat << EOF > /etc/default/isc-dhcp-relay
SERVERS="10.91.1.194"
INTERFACESv4="eth0 eth1 eth2"
EOF

service isc-dhcp-relay restart
