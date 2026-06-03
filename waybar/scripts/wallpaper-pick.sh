#!/bin/bash
WALLPAPER=$(zenity --file-selection \
    --title="选择壁纸" \
    --filename="$HOME/wallpapers/" \
    --file-filter="图片文件 (*.jpg *.jpeg *.png) | *.jpg *.jpeg *.png" 2>/dev/null)

if [ -z "$WALLPAPER" ]; then
    exit 0
fi

MONITORS=$(hyprctl monitors 2>/dev/null | grep "^Monitor" | awk '{print $2}')
if [ -z "$MONITORS" ]; then
    hyprctl hyprpaper wallpaper ",$WALLPAPER" 2>/dev/null
else
    for mon in $MONITORS; do
        hyprctl hyprpaper wallpaper "$mon,$WALLPAPER" 2>/dev/null
    done
fi

notify-send "Wallpaper" "$(basename "$WALLPAPER")" 2>/dev/null
