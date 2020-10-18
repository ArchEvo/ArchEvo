#!/bin/bash

pacman -Syyu
pacman -S gnome gdm nautilus-share --noconfirm

#-->Service
systemctl enable gdm 
