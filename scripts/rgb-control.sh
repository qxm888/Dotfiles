#!/bin/bash
# RGB 灯效控制脚本 - ASUS TX GAMING B760M WIFI
# 用法: rgb-control.sh <模式> [颜色] [速度]
# 模式: off | static | breathing | rainbow | chase | flashing
# 颜色: FF0000(红) 00FF00(绿) 0000FF(蓝) FF00FF(紫) FFFFFF(白) ...

MODE="${1:-breathing}"
COLOR="${2:-FF00FF}"
SPEED="${3:-50}"

case "$MODE" in
    off)
        openrgb --noautoconnect --device 0 --mode Off
        echo "RGB 已关闭"
        ;;
    static|breathing|flashing|chase)
        openrgb --noautoconnect --device 0 --mode "${MODE^}" --color "$COLOR"
        echo "RGB 模式: $MODE, 颜色: #$COLOR"
        ;;
    rainbow|spectrum)
        openrgb --noautoconnect --device 0 --mode Rainbow
        echo "RGB 彩虹模式"
        ;;
    *)
        echo "用法: $0 {off|static|breathing|rainbow|chase|flashing} [颜色]"
        echo "示例:"
        echo "  $0 breathing ff0000    # 红色呼吸灯"
        echo "  $0 static 00ff00       # 绿色常亮"
        echo "  $0 rainbow             # 彩虹循环"
        echo "  $0 off                 # 关灯"
        ;;
esac
