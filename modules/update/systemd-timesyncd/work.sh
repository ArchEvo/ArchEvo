#!/bin/bash

sed -i 's/#FallbackNTP=0.arch.pool.ntp.org/FallbackNTP=0.arch.pool.ntp.org/g' /etc/systemd/timesyncd.conf
sed -i 's/#NTP=/NTP=pool.ntp.org/g' /etc/systemd/timesyncd.conf

systemctl enable systemd-networkd
systemctl enable systemd-timesyncd

systemctl start systemd-networkd
systemctl start systemd-timesyncd
