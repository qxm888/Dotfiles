#!/bin/bash

data=$(hyprctl activewindow -j 2>/dev/null)

if [ -z "$data" ]; then
    echo '{"text": ""}'
    exit 0
fi

class=$(echo "$data" | python3 -c "import sys,json; print(json.load(sys.stdin).get('class',''))")
title=$(echo "$data" | python3 -c "import sys,json; print(json.load(sys.stdin).get('title',''))")

case "$class" in
    firefox|Firefox|firefoxdeveloperedition)       icon="󰈹" ;;
    kitty|Kitty)                                    icon="󰄛" ;;
    code-oss|Code|code|vscodium)                   icon="󰨞" ;;
    thunar|Thunar)                                  icon="󰝰" ;;
    steam|steamwebhelper)                           icon="󰓓" ;;
    obsidian|Obsidian)                              icon="󰓩" ;;
    spotify|Spotify)                                icon="󰓇" ;;
    discord|Discord)                                icon="󰙯" ;;
    telegramdesktop|TelegramDesktop)                icon="󰛲" ;;
    chromium|Chromium|google-chrome)                icon="󰊯" ;;
    mpv|Mpv)                                        icon="󰐹" ;;
    gimp|Gimp)                                      icon="󰏘" ;;
    blender|Blender)                                icon="󰂜" ;;
    obs|OBS)                                        icon="󰑋" ;;
    qq|QQ)                                          icon="󰘚" ;;
    wechat|WeChat|微信)                              icon="󰘑" ;;
    *)                                              icon="󰣆" ;;
esac

MAX_LEN=40
display="${icon}  ${title}"
if [ ${#display} -gt $MAX_LEN ]; then
    display="${display:0:$MAX_LEN}…"
fi

echo "{\"text\": \"$display\", \"class\": \"$class\"}"
