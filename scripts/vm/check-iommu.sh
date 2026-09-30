#!/bin/bash
# 检查 IOMMU 分组
echo "========================================="
echo "  IOMMU 分组检测"
echo "========================================="

if [ ! -d /sys/kernel/iommu_groups ]; then
    echo "[!] IOMMU 未启用！请确认已添加 intel_iommu=on 并重启"
    exit 1
fi

echo ""
echo "显卡相关设备 IOMMU 分组："
echo "-----------------------------------------"
for g in $(find /sys/kernel/iommu_groups/ -type l 2>/dev/null); do
    dev="$(basename "$(dirname "$g")")"
    pci="$(basename "$g")"
    desc="$(lspci -nns "$pci" 2>/dev/null)"
    if echo "$desc" | grep -qiE "vga|3d|display|audio|nvidia|usb"; then
        echo "  IOMMU Group $dev: $desc"
    fi
done

echo ""
echo "所有 PCI 设备 IOMMU 分组："
echo "-----------------------------------------"
for g in $(find /sys/kernel/iommu_groups/ -type l 2>/dev/null | sort -t/ -k5 -n); do
    dev="$(basename "$(dirname "$g")")"
    pci="$(basename "$g")"
    desc="$(lspci -nns "$pci" 2>/dev/null)"
    echo "  IOMMU Group $dev: $desc"
done

echo ""
echo "========================================="
echo "  检测完成！"
echo "  显卡(01:00.0/01:00.1)应同在或不同组"
echo "  USB控制器(04:00.0)应单独一组"
echo "========================================="
