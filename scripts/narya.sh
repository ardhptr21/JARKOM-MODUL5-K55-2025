#!/bin/bash

grep -qF 'nameserver 8.8.8.8' /etc/resolv.conf || echo 'nameserver 8.8.8.8' >> /etc/resolv.conf

ln -s /etc/init.d/named /etc/init.d/bind9

cat << EOF > /etc/bind/named.conf.options
options {
  directory "/var/cache/bind";
  dnssec-validation auto;
  forwarders {
      8.8.8.8;
  };
  allow-query { any; };
  auth-nxdomain no;
  listen-on-v6 { any; };
};
EOF

service bind9 restart