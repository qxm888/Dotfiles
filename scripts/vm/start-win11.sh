#!/bin/bash
# 单显卡直通启动 Win11 VM
#
# 使用方式：
#   1. 保存所有工作
#   2. Ctrl+Alt+F2 切换到 TTY2
#   3. 登录后运行: ~/opencode/scripts/vm/start-win11.sh
#   4. 显示器将显示 Win11 安装/桌面
#   5. 关闭 Win11 后自动回到 TTY，
#      输入 Hyprland 返回桌面

VM_NAME="win11"

echo "========================================"
echo "  Win11 单显卡直通启动器"
echo "  使用前请确保已保存所有工作！"
echo "========================================"
echo ""

# 检查是否在 TTY 中运行
if [ -n "$WAYLAND_DISPLAY" ] || [ -n "$DISPLAY" ]; then
    echo "[!] 请在纯 TTY 中运行此脚本！"
    echo "    Ctrl+Alt+F2 切换到 TTY2，登录后重试"
    exit 1
fi

read -p "按 Enter 启动 Win11 VM，或 Ctrl+C 取消..."

echo "[*] 终止桌面会话..."
pkill -u $USER Hyprland 2>/dev/null || true
sleep 2

echo "[*] 释放 nvidia 驱动..."
sudo modprobe -r nvidia_drm nvidia_modeset nvidia_uvm nvidia 2>/dev/null || true
sleep 1

echo "[*] 启动 VM: $VM_NAME ..."
virsh start $VM_NAME

echo ""
echo "[*] VM 已启动！显示器将显示 Win11"
echo "[*] 关闭 Win11 后脚本将自动继续..."
echo ""

virsh event $VM_NAME --event lifecycle --timeout 0 || true

echo ""
echo "[*] VM 已关闭，恢复 nvidia 驱动..."
sleep 2
sudo modprobe nvidia_drm nvidia_modeset nvidia_uvm nvidia 2>/dev/null || true
sleep 1

echo ""
echo "========================================"
echo "  恢复完成！输入 Hyprland 返回桌面"
echo "  或输入 exit 返回登录"
echo "========================================"
