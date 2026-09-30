

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

### 一键同步（推荐）

```bash
bash scripts/sync.sh                  # 同步 → 隐私扫描 → 提交 → 推送所有远程
bash scripts/sync.sh -n               # 预览，不改文件、不提交
bash scripts/sync.sh -m "改了键位"     # 自定义提交说明
```

脚本会按 `hypr/ kitty/ fish/ fcitx5/ btop/ fastfetch/ ohmyposh/ systemd/ shell/ scripts/`
的映射把 `~/.config` 与家目录里的配置同步回仓库，先跑一遍**隐私/密钥扫描**
（密码 / token / 私钥 / 公网 IP / 手机号），通过后自动 commit 并推送到 Gitee + GitHub 两个远程。
误报写进 `.secretscan-ignore` 即可。

> 源家目录默认由仓库位置推导（`<home>/opencode/<repo>` → `<home>`），可用 `-H` 覆盖。

### 提交前自动扫描（防手滑把密码推上去）

仓库自带 `.githooks/pre-commit`：`git commit` 前自动扫描暂存区，命中密码 / token /
私钥 / 公网 IP / 手机号就阻断提交。新克隆后启用一次（`scripts/sync.sh` 会自动设置）：

```bash
git config core.hooksPath .githooks
```

手动扫描：`bash scripts/secretscan.sh`；确认真无害时 `git commit --no-verify` 可跳过。

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

[MIT](LICENSE) © 2026 **Dovahkiin**

欢迎随意取用、修改、再分发，甚至商用 —— 只要保留版权声明即可。
配置这种东西本来就该互相抄来抄去，拿走不谢 😄
