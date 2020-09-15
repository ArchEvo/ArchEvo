#!/bin/bash

pacman -Syyu
pacman -S gnome gdm --noconfirm

#-->Service
systemctl enable gdm 
