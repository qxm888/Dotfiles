#!/bin/bash
PID_FILE="$HOME/.cache/wallpaper-auto.pid"

if [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE")
    if kill -0 "$PID" 2>/dev/null; then
        kill "$PID"
        rm -f "$PID_FILE"
        notify-send "Wallpaper Auto" "已停止" 2>/dev/null
        exit 0
    fi
fi

WALLPAPER_DIR="$HOME/wallpapers"

(
    echo $$ > "$PID_FILE"
    while true; do
        WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" \) 2>/dev/null | shuf | head -1)
        if [ -n "$WALLPAPER" ]; then
            MONITORS=$(hyprctl monitors 2>/dev/null | grep "^Monitor" | awk '{print $2}')
            if [ -z "$MONITORS" ]; then
                hyprctl hyprpaper wallpaper ",$WALLPAPER" 2>/dev/null
            else
                for mon in $MONITORS; do
                    hyprctl hyprpaper wallpaper "$mon,$WALLPAPER" 2>/dev/null
                done
            fi
        fi
        sleep 60
    done
) &

echo $! > "$PID_FILE"
notify-send "Wallpaper Auto" "已启动（每60秒切换）" 2>/dev/null
