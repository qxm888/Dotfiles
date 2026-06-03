#!/bin/bash
WALLPAPER_DIR="$HOME/wallpapers"

WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" \) 2>/dev/null | shuf | head -1)

if [ -z "$WALLPAPER" ]; then
    notify-send "Wallpaper" "No wallpapers found" 2>/dev/null
    exit 1
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
