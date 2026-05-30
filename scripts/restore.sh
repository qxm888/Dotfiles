#!/usr/bin/env bash
set -euo pipefail

# ============================================================
#  dotfiles 快速恢复脚本 — Arch Linux + Hyprland
#  用法: bash <(curl -fsSL https://gitee.com/luminous-spirit/my-dotfiles/raw/master/scripts/restore.sh)
#  或:  git clone git@gitee.com:luminous-spirit/my-dotfiles.git
#       cd my-dotfiles && bash scripts/restore.sh
# ============================================================

DOTFILES_REPO="https://gitee.com/luminous-spirit/my-dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

log()  { echo -e "${GREEN}[✓]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }
err()  { echo -e "${RED}[✗]${NC} $1"; }
info() { echo -e "${CYAN}[i]${NC} $1"; }

ask() {
    local prompt=$1 default=${2:-y}
    local yn
    if [[ $default == "n" ]]; then
        yn="[y/N]"
    else
        yn="[Y/n]"
    fi
    read -r -p "$(echo -e "${YELLOW}?${NC} $prompt $yn ") " answer
    if [[ -z $answer ]]; then
        answer=$default
    fi
    [[ $answer =~ ^[Yy]$ ]]
}

# ------- 前置检查 -------
if [[ ! -f /etc/arch-release ]]; then
    warn "检测到非 Arch Linux 系统，脚本主要为 Arch Linux 设计"
    ask "是否继续？" n || exit 1
fi

# ------- 获取 dotfiles -------
if [[ -d $DOTFILES_DIR ]]; then
    warn "$DOTFILES_DIR 已存在"
    if ask "重新拉取最新版本？" n; then
        rm -rf "$DOTFILES_DIR"
        git clone --depth=1 "$DOTFILES_REPO" "$DOTFILES_DIR"
    fi
else
    info "正在克隆 dotfiles 仓库..."
    git clone --depth=1 "$DOTFILES_REPO" "$DOTFILES_DIR"
fi
log "dotfiles 已下载到 $DOTFILES_DIR"

cd "$DOTFILES_DIR"

# ------- 安装依赖包 -------
info "以下软件包将被安装:"
echo ""
echo "  [桌面] hyprland waybar hyprpaper hyprshot hyprlock hypridle xdg-desktop-portal-hyprland"
echo "  [终端] kitty fish"
echo "  [输入] fcitx5 fcitx5-rime fcitx5-configtool fcitx5-qt fcitx5-gtk"
echo "  [工具] btop fastfetch wl-clipboard cliphist thunar ffmpegthumbnailer"
echo "  [声音] pipewire pipewire-pulse wireplumber playerctl"
echo "  [亮度] brightnessctl"
echo "  [外观] nerd-fonts oh-my-posh qt5ct qt6ct kvantum"
echo "  [截图] grim slurp swappy"
echo "  [通知] dunst libnotify polkit-kde-agent"
echo "  [网络] networkmanager"
echo "  [其他] unzip tar wget curl git"
echo ""

if ask "是否安装以上软件包？(使用 pacman + paru/yay)"; then
    info "请确保已启用 multilib 仓库"

    # 检测 AUR 助手
    AUR_HELPER=""
    for cmd in paru yay; do
        if command -v $cmd &>/dev/null; then
            AUR_HELPER=$cmd
            break
        fi
    done

    PKGS=(
        hyprland waybar hyprpaper hyprshot hyprlock hypridle
        xdg-desktop-portal-hyprland
        kitty fish btop fastfetch
        fcitx5 fcitx5-rime fcitx5-configtool fcitx5-qt fcitx5-gtk
        wl-clipboard cliphist thunar ffmpegthumbnailer tumbler
        pipewire pipewire-pulse wireplumber playerctl
        brightnessctl
        ttf-jetbrains-mono-nerd noto-fonts-cjk noto-fonts-emoji
        qt5ct qt6ct kvantum
        grim slurp swappy
        dunst libnotify polkit-kde-agent
        networkmanager
        unzip tar wget curl git
    )

    echo ""
    info "正在使用 pacman 安装..."
    sudo pacman -S --needed --noconfirm "${PKGS[@]}" 2>/dev/null || {
        warn "部分包可能不在官方源中，尝试 AUR..."
    }

    if [[ -n $AUR_HELPER ]]; then
        AUR_PKGS=(oh-my-posh-bin hyprshot hyprlock hypridle)
        info "正在使用 $AUR_HELPER 安装 AUR 包..."
        $AUR_HELPER -S --needed --noconfirm "${AUR_PKGS[@]}" 2>/dev/null || true
    else
        warn "未检测到 AUR 助手(paru/yay)，跳过 AUR 包安装"
        warn "稍后请手动安装: oh-my-posh"
    fi
    log "软件包安装完成"
fi

# ------- 恢复配置文件 -------
restore_dir() {
    local src=$1 dest=$2
    if [[ -d $dest ]]; then
        warn "$dest 已存在"
        if ask "备份原配置并覆盖？" y; then
            local bak="${dest}.bak.$(date +%Y%m%d-%H%M%S)"
            mv "$dest" "$bak"
            info "原配置已备份到 $bak"
        else
            info "跳过 $dest"
            return
        fi
    fi
    mkdir -p "$(dirname "$dest")"
    cp -r "$src" "$dest"
    log "已恢复: $dest"
}

echo ""
info "========== 开始恢复配置文件 =========="

restore_dir "$DOTFILES_DIR/hypr"      "$HOME/.config/hypr"
restore_dir "$DOTFILES_DIR/kitty"     "$HOME/.config/kitty"
restore_dir "$DOTFILES_DIR/fish"      "$HOME/.config/fish"
restore_dir "$DOTFILES_DIR/ohmyposh"  "$HOME/.config/ohmyposh"
restore_dir "$DOTFILES_DIR/btop"      "$HOME/.config/btop"
restore_dir "$DOTFILES_DIR/fastfetch" "$HOME/.config/fastfetch"
restore_dir "$DOTFILES_DIR/fcitx5"    "$HOME/.config/fcitx5"
restore_dir "$DOTFILES_DIR/systemd"   "$HOME/.config/systemd/user"

# Shell 配置文件
for f in bashrc bash_profile zshrc; do
    src="$DOTFILES_DIR/shell/.$f"
    dest="$HOME/.$f"
    if [[ -f $dest ]]; then
        warn "$dest 已存在"
        if ask "覆盖？" n; then
            cp "$src" "$dest"
            log "已恢复: $dest"
        fi
    else
        cp "$src" "$dest"
    fi
done

# ------- 设置 Fish 为默认 Shell -------
if ask "是否将 Fish 设为默认 Shell？"; then
    if grep -q "$(which fish)" /etc/shells 2>/dev/null; then
        chsh -s "$(which fish)"
        log "默认 Shell 已设为 Fish"
    else
        warn "Fish 未在 /etc/shells 中，添加中..."
        echo "$(which fish)" | sudo tee -a /etc/shells
        chsh -s "$(which fish)"
        log "默认 Shell 已设为 Fish"
    fi
fi

# ------- 启用服务 -------
info "正在启用系统服务..."
systemctl --user enable pipewire pipewire-pulse wireplumber 2>/dev/null || true
systemctl --user start pipewire pipewire-pulse wireplumber 2>/dev/null || true
sudo systemctl enable NetworkManager --now 2>/dev/null || true

# ------- 壁纸提示 ----
echo ""
info "========== 壁纸 =========="
warn "壁纸文件太大，未纳入 Git 仓库管理"
warn "你可以手动把壁纸复制到 ~/wallpapers/"
echo ""
info "当前 hyprpaper.conf 中引用壁纸:"
grep -r "wallpaper\|preload" "$DOTFILES_DIR/hypr/hyprpaper.conf" 2>/dev/null || echo "  无"

# ------- 完成 -------
echo ""
echo -e "${GREEN}========================================"
echo "  dotfiles 恢复完成！"
echo -e "========================================${NC}"
echo ""
echo "  下一步:"
echo "    1. 重启 Hyprland (或重新登录)"
echo "    2. 手动将壁纸文件放到 ~/wallpapers/"
echo "    3. 如有需要，运行 fish 进入 Fish shell"
echo "    4. 查看文档: https://gitee.com/luminous-spirit/my-dotfiles"
echo ""
echo -e "${YELLOW}  快捷键提示:${NC}"
echo "    Super+Enter  → Kitty 终端"
echo "    Super+B      → Firefox 浏览器"
echo "    Super+E      → Thunar 文件管理器"
echo "    Super+Q      → 关闭窗口"
echo "    Super+1~0    → 切换工作区"
echo "    Super+S      → 切换魔法工作区（scratchpad）"
echo "    Print        → 截图（区域）"
echo ""
echo -e "${GREEN}欢迎回来，亲爱的~ ❤️${NC}"
