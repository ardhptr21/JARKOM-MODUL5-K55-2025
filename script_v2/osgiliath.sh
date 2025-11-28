#!/bin/bash

apt update
apt install iptables -y

iptables -t nat -F POSTROUTING
iptables -t nat -A POSTROUTING -s 10.91.0.0/16 -o eth0 -j SNAT --to-source 192.168.122.126