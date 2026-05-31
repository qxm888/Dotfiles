

# 我的 Dotfiles 配置文件

这是我在 Linux 系统上的个性化配置文件仓库，包含多种现代工具和桌面环境的配置。

## 项目简介

本仓库收集了我在日常 Linux 使用中积累的各种配置文件，涵盖了从终端到桌面环境的完整工具链。主要包括：

- **Shell 配置**: Fish、Bash、Zsh
- **终端模拟器**: Kitty
- **窗口管理器**: Hyprland (Wayland)
- **系统监控**: btop、fastfetch
- **输入法**: Fcitx5 + Rime
- **命令提示符**: ohmyposh
- **自动化脚本**: 系统快照与恢复

## 主要工具

| 类别 | 工具 | 说明 |
|------|------|------|
| Shell | Fish | 现代交互式 shell |
| 终端 | Kitty | GPU 渲染的终端模拟器 |
| 窗口管理 | Hyprland | Wayland 合成器 |
| 输入法 | Fcitx5 + Rime | 中文输入法框架 |
| 系统信息 | fastfetch | 快速获取系统信息 |
| 进程监控 | btop | 现代版 top/htop |

## 目录结构

```
├── btop/              # btop 主题配置
├── fastfetch/         # fastfetch 预设配置
├── fcitx5/            # Fcitx5 输入法配置
├── fish/             # Fish shell 配置
├── hypr/              # Hyprland 配置
├── kitty/            # Kitty 终端配置
├── ohmyposh/         # ohmyposh 主题
├── scripts/          # 辅助脚本
├── shell/            # Shell 基础配置
└── systemd/         # 系统服务单元
```

## 备份与恢复

`scripts/` 目录下包含自动化脚本，支持系统的自动快照和配置恢复功能。

## 使用说明

### 同步配置

可以使用软链接或符号链接将配置文件关联到对应位置：

```bash
ln -s ~/dotfiles/fish/config.fish ~/.config/fish/config.fish
ln -s ~/dotfiles/hypr/conf ~/.config/hypr/conf
```

### 自动恢复

运行恢复脚本自动还原配置：

```bash
./scripts/restore.sh
```

## 依赖组件

- Linux 发行版（Arch Linux 推荐）
- Hyprland
- Fish Shell
- Kitty
- Fcitx5 + Rime
- fastfetch
- btop
- ohmyposh

## 许可证

本配置文件仅供个人学习和使用，欢迎参考和借鉴。