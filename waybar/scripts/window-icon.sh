#!/bin/bash

class=$(hyprctl activewindow -j 2>/dev/null | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('class',''))")

case "$class" in
    firefox|Firefox|firefoxdeveloperedition)       icon="󰈹" ;;
    kitty|Kitty)                                    icon="󰄛" ;;
    code-oss|Code|code|vscodium)                   icon="󰨞" ;;
    thunar|Thunar)                                  icon="󰝰" ;;
    steam|steamwebhelper)                           icon="󰓓" ;;
    obsidian|obsidian)                              icon="󰓩" ;;
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

echo "$icon"
