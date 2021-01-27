#!/bin/bash

pacman -S --noconfirm --needed ufw ufw-extras conntrack-tools

systemctl enable ufw
sed -i 's/ENABLED=no/ENABLED=yes/g' /etc/ufw/ufw.conf
ufw enable

# enable helpers
echo "options nf_conntrack nf_conntrack_helper=1" > /etc/modprobe.d/nf_conntrack.conf

# regulate
ufw allow CIFS
