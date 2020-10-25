#!/bin/bash

pacman -Syy
pacman -S gnome gdm nautilus-share --noconfirm

#-->Service
systemctl enable gdm 
