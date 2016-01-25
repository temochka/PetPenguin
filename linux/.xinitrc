#!/bin/bash
session=${1:-dwm}

eval $(ssh-agent)

# Explicitly load the profile
if [ -f ~/.profile ]; then
    source ~/.profile
fi

# Auto-adjust DPI based on the used display
if [ -f ~/.auto-dpi.sh ]; then
    source ~/.auto-dpi.sh
fi

# Fix unreasonable keypress defaults on Linux
xset r rate 200 30

# Run VirtualBox helper programs
VBoxClient-all

# Load wallpaper if set
if [ -f ~/.fehbg ]; then
    eval $(cat ~/.fehbg)
fi

# Run extensions
if [ -f ~/.xinitrc.ext ]; then
    source ~/.xinitrc.ext
fi

# Start the window manager
case $session in
  dwm)
    exec ~/bin/dwmdwmdwm
    ;;
esac

