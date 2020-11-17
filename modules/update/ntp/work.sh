#!/bin/bash

pacman -S ntp --noconfirm


#-->Service
systemctl stop ntpd
#sync time
ntpd -q
systemctl start ntpd
systemctl enable ntpd
