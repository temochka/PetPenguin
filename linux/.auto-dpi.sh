#!/bin/bash

resolution=$(xrandr | head -n 1 | sed -e "s/.* current \([[:digit:]]\+ x [[:digit:]]\+\).*/\1/")

xrandr --auto
xrdb -merge ~/.Xresources

case $resolution in
  # Hopefully, Apple Thunderbult Display 27"
  "2560 x 1440")
    export UI_SCALE_FACTOR=1
    ln -fs ~/.config/fontconfig.avail/lodpi-fonts.conf ~/.config/fontconfig/fonts.conf
    xrandr --dpi 109
    xrdb -merge ~/.Xresources.lodpi
    ;;
  # Hopefully, Apple MacBook Pro 13"
  "2560 x 1600")
    ln -fs ~/.config/fontconfig.avail/hidpi-fonts.conf ~/.config/fontconfig/fonts.conf
    export UI_SCALE_FACTOR=2
    export GTK_SCALE=2
    xrandr --dpi 227
    xrdb -merge ~/.Xresources.hidpi
    ;;
  *)
    echo "Unknown resolution, only God can help us now..."
    ;;
esac

