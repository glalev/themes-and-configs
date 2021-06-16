#!/bin/bash
MAIN="Main"
PROJECTOR="Projector"
PROJECTORSCALED="Projector Scaled"
SECONDARY="Secondary On"

CHOICE=$(printf "${MAIN}\n${SECONDARY}\n${PROJECTOR}\n${PROJECTORSCALED}\n" | dmenu -fn 'Hack Nerd Font:normal:pixelsize=30' -p "Displays Setup:" -nb '#3B4252' -sf '#5E81AC' -sb '#3B4252' -nf '#E5E9F0')

if [ "$MAIN" == "$CHOICE" ];
then
    xrandr --output DP-2 --auto --scale 1x1;
    xrandr --output DP-0 --off;
    xrandr --output HDMI-0 --off;
elif [ "$PROJECTOR" == "$CHOICE" ];
then
    xrandr --output HDMI-0 --auto --scale 2x2;
    xrandr --output DP-2 --off;
    xrandr --output DP-0 --off;
elif [ "$PROJECTORSCALED" == "$CHOICE" ];
then
    xrandr --output HDMI-0 --auto --scale 1x1;
    xrandr --output DP-2 --off;
    xrandr --output DP-0 --off;
elif [ "$SECONDARY" == "$CHOICE" ];
then
    xrandr --output DP-2 --auto --scale 1x1;
    xrandr --output DP-0 --auto --right-of DP-2 --rotate left --scale 2x2;
    xrandr --output HDMI-0 --off;
fi
