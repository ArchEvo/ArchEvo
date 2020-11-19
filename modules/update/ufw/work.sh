#!/bin/bash

pacman -S ufw gufw --noconfirm

systemctl enable ufw
sed -i 's/ENABLED=no/ENABLED=yes/g' /etc/ufw/ufw.conf
