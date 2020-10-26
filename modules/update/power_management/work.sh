#!/bin/bash

pacman -S --noconfirm acpid tlp powertop

systemctl enable acpid
systemctl enable tlp
