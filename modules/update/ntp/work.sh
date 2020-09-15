#!/bin/bash

pacman -S ntp --noconfirm


#-->Service
systemctl enable ntpd
