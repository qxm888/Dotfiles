#!/bin/bash
# auto-snapshot.sh

SNAPSHOT_DIR="/.snapshots"
#SNAPSHOT_DIRH="/.homesnapshots"
DATE=$(date +%Y%m%d-%H%M%S)

# 创建根快照
sudo btrfs subvolume snapshot -r / "$SNAPSHOT_DIR/root-$DATE"

# 创建 home 快照（如果单独子卷）
if [ -d "/home" ]; then
    sudo btrfs subvolume snapshot -r /home "$SNAPSHOT_DIR/home-$DATE"
fi

# 保留最近7天的快照
find "$SNAPSHOT_DIR" -maxdepth 1 -name "root-*" -type d | sort -r | tail -n +8 | xargs -r sudo btrfs subvolume delete
#find "$SNAPSHOT_DIRH" -maxdepth 1 -name "home-*" -type d | sort -r | tail -n +8 | xargs -r sudo btrfs subvolume delete
