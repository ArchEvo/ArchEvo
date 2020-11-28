#!/bin/bash

pacman -S --noconfirm --needed networkmanager

#-->Service
systemctl enable NetworkManager
