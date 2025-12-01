#!/bin/bash

# --- BAGIAN 1: SETUP DASAR & INTERNET (Misi 1 No 2) ---
grep -qF 'nameserver 8.8.8.8' /etc/resolv.conf || echo 'nameserver 8.8.8.8' >> /etc/resolv.conf
ln -s /etc/init.d/named /etc/init.d/bind9 2>/dev/null

apt update
apt install bind9 -y

cat << EOF > /etc/bind/named.conf.options
options {
  directory "/var/cache/bind";
  dnssec-validation auto;
  forwarders { 8.8.8.8; };
  allow-query { any; };
  auth-nxdomain no;
  listen-on-v6 { any; };
};
EOF

# --- BAGIAN 2: SETUP ZONE ARDA.LOCAL (Misi 1 No 3) ---
# Mendaftarkan domain arda.local
cat << EOF > /etc/bind/named.conf.local
zone "arda.local" {
    type master;
    file "/etc/bind/db.arda.local";
};
EOF

# Membuat Database Domain (Mapping Nama -> IP)
cp /etc/bind/db.local /etc/bind/db.arda.local
cat << EOF > /etc/bind/db.arda.local
;
; BIND data file for arda.local
;
\$TTL    604800
@       IN      SOA     arda.local. root.arda.local. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      arda.local.
@       IN      A       10.91.1.195
www     IN      CNAME   arda.local.
palantir    IN  A       10.91.1.234
ironhills   IN  A       10.91.1.218
EOF

service bind9 restart