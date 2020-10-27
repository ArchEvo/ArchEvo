#!/bin/bash

pacman -S --noconfirm avahi


#-->Service
systemctl enable avahi-daemon

# NOTE
# avahi is required to get a simple access to samba server with nautilus, for example ...
