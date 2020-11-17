#!/bin/bash

#config root
timedatectl set-timezone $INPUT_TIMEZONE_CONTINENT/$INPUT_TIMEZONE_CITY
timedatectl set-ntp true

#config user
su $INPUT_USER_NAME -c "timedatectl set-timezone $INPUT_TIMEZONE_CONTINENT/$INPUT_TIMEZONE_CITY"
su $INPUT_USER_NAME -c "timedatectl set-ntp true"

timedatectl set-local-rtc 0 --adjust-system-clock
