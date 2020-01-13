#!/bin/bash

# https://github.com/phillipberndt/autorandr
# Setup for Autorandr for use with i3wm
# This is pretty hard coded but I guess monitors don't change too much

# NB You can also set size
# xrandr --output DP1-1 --auto --left-of eDP1 -s 2560x1440

# Installation
sudo pip install autorandr

read -n 1 -s -r -p "LAPTOP - Disconnect monitors and press any key to continue"

# Laptop only
xrandr --output eDP1 --auto

read -n 1 -s -r -p "DUAL - connect monitor and press any key"

# Dual Monitors
xrandr --output DP1-1 --auto --left-of eDP1
autorandr --save dual

read -n 1 -s -r -p "CLAMSHELL - Keep monitor connected and press any key"

# Clamshell Mode - BENQ
xrandr --output eDP1 --off
xrandr --output DP1-1 -s 2560x1440
