#!/bin/bash

# Configuration directory
mkdir -p /opt/ArchEvoConf
rm /opt/ArchEvoConf/*

./input/select_key_map.py

./input/select_drive.py
./input/select_luks_password.py
./input/select_swap_size.py

./input/select_hostname.py
./input/select_timezone.py
./input/select_locale.py

./input/select_root_password.py
./input/select_user_name.py
./input/select_user_password.py

./input/select_gpu.py
./input/select_linux_version.py
