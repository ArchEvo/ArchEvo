#!/bin/bash

pacman -S --noconfirm --needed btrfs-progs dosfstools f2fs-tools e2fsprogs jfsutils nilfs-utils ntfs-3g reiserfsprogs udftools xfsprogs squashfs-tools nfs-utils mtpfs

# enable essential services
systemctl enable btrfs-scrub@-.timer
systemctl enable btrfs-scrub@home.timer
#systemctl enable btrfs-scrub@swap.timer # Good idea?
systemctl enable btrfs-scrub@snapshots.timer
