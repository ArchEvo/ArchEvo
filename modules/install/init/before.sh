#!/bin/bash

timedatectl set-timezone $INPUT_TIMEZONE_CONTINENT/$INPUT_TIMEZONE_CITY
timedatectl set-ntp true

pacman -Sy --noconfirm haveged
systemctl daemon-reload
systemctl start haveged
