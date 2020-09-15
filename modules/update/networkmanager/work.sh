#!/bin/bash

pacman -S networkmanager --noconfirm

#-->Service
systemctl enable NetworkManager
