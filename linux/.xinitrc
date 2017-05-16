#!/bin/bash
session=${1:-dwm}

eval $(ssh-agent)

# Explicitly load the profile
if [ -f ~/.profile ]; then
    . ~/.profile
fi

# Auto-adjust DPI based on the used display
if [ -f ~/.auto-dpi.sh ]; then
    . ~/.auto-dpi.sh
fi

# Fix unreasonable keypress defaults on Linux
xset r rate 200 30

# Disable screensaver
xset -dpms s off

# Add Russian keyboard layout with toggle shortcut Left Ctrl + Left Shift
setxkbmap -layout us,ru -option grp:lctrl_lshift_toggle

# Run VirtualBox helper programs
VBoxClient-all

# Load wallpaper if set
if [ -f ~/.fehbg ]; then
    eval $(~/.fehbg)
fi

# Run extensions
if [ -f ~/.xinitrc.ext ]; then
    . ~/.xinitrc.ext
fi

# Start the window manager
case $session in
  dwm)
    exec ~/bin/dwmdwmdwm
    ;;
esac

