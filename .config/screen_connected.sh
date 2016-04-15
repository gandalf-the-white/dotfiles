#!/bin/bash

IN="LVDS1"
EXT="DVI1"

if (xrandr | grep "$EXT disconnected"); then
   xrandr --output $EXT --off --output $IN --auto
else
   xrandr --output $IN --auto --output $EXT --auto --right-of $IN
fi
