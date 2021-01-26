#!/bin/bash

pacman -S --noconfirm --needed ufw gufw

systemctl enable ufw
sed -i 's/ENABLED=no/ENABLED=yes/g' /etc/ufw/ufw.conf
ufw enable

# regulate
ufw allow CIFS
