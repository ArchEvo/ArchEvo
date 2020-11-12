#!/bin/bash

pacman -S ufw gufw --noconfirm

systemctl enable ufw

#ufw enable 
