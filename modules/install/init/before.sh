#!/bin/bash

#load kernel module
modprobe ip6table_filter #required by ufw for new rules

systemctl restart systemd-timesyncd
sleep 1
timedatectl set-timezone $INPUT_TIMEZONE_CONTINENT/$INPUT_TIMEZONE_CITY
timedatectl set-ntp true

pacman -Sy --noconfirm haveged
systemctl daemon-reload
systemctl start haveged
