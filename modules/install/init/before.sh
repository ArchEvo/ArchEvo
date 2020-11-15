#!/bin/bash

timedatectl set-timezone $INPUT_TIMEZONE_CONTINENT/$INPUT_TIMEZONE_CITY
timedatectl set-ntp true
