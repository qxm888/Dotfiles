#!/usr/bin/env bash
# 延时区域截图 → 剪贴板
# 用法: hyprshot-delay-region.sh [秒数]   (默认 3 秒)

set -e

DELAY="${1:-3}"

REGION=$(slurp)

notify-send "延时选区截图" "将在 ${DELAY} 秒后截图" -t $((DELAY * 1000)) -a Hyprshot

sleep "$DELAY"

grim -g "$REGION" - | wl-copy --type image/png
notify-send "截图已复制到剪贴板" -t 2000 -a Hyprshot
