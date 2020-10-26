#!/bin/bash

pacman-key --populate archlinux
pacman-key --refresh-keys
pacman -Syy --noconfirm archlinux-keyring
