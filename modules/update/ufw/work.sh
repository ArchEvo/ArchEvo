#!/bin/bash

pacman -S --noconfirm --needed ufw gufw

systemctl enable ufw
sed -i 's/ENABLED=no/ENABLED=yes/g' /etc/ufw/ufw.conf

# The "ip6table_filter" module is not loaded in the installation environment but is required by ufw for new rules.
modprobe ip6table_filter

# regulate
ufw allow CIFS
