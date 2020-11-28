#!/bin/bash

pacman -S --noconfirm --needed ntp


#-->Service
systemctl stop ntpd
#sync time
ntpd -q
systemctl start ntpd
systemctl enable ntpd
