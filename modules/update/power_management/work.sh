#!/bin/bash

pacman -S --noconfirm --needed acpid tlp powertop

systemctl enable acpid
systemctl enable tlp
