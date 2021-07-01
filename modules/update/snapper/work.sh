#!/bin/bash

pacman -S --noconfirm --needed snapper snap-pac grub-btrfs cronie


# set config
sed -i 's/TIMELINE_LIMIT_HOURLY="10"/TIMELINE_LIMIT_HOURLY="0"/' /etc/snapper/configs/root
sed -i 's/TIMELINE_LIMIT_DAILY="10"/TIMELINE_LIMIT_DAILY="7"/' /etc/snapper/configs/root
sed -i 's/TIMELINE_LIMIT_MONTHLY="10"/TIMELINE_LIMIT_MONTHLY="1"/' /etc/snapper/configs/root
sed -i 's/TIMELINE_LIMIT_YEARLY="10"/TIMELINE_LIMIT_YEARLY="1"/' /etc/snapper/configs/root
sed -i 's/TIMELINE_CREATE="yes"/TIMELINE_CREATE="no"/' /etc/snapper/configs/root

# enable snapper services
systemctl enable cron.service
systemctl enable snapper-cleanup.timer
systemctl enable snapper-timeline.timer
systemctl enable snapper-boot.timer
systemctl enable grub-btrfs.path
