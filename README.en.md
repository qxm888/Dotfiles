# My Dotfiles Configuration

This is my personal configuration repository for Linux systems, containing configurations for various modern tools and desktop environments.

## Project Overview

This repository collects various configuration files I've accumulated during daily Linux usage, covering the complete toolchain from terminal to desktop environment. Main components include:

- **Shell configurations**: Fish, Bash, Zsh
- **Terminal emulator**: Kitty
- **Window manager**: Hyprland (Wayland)
- **System monitoring**: btop, fastfetch
- **Input method**: Fcitx5 + Rime
- **Prompt theme**: ohmyposh
- **Automation scripts**: System snapshot and restore

## Key Tools

| Category | Tool | Description |
|----------|------|-------------|
| Shell | Fish | Modern interactive shell |
| Terminal | Kitty | GPU-accelerated terminal emulator |
| Window Manager | Hyprland | Wayland compositor |
| Input Method | Fcitx5 + Rime | Chinese input method framework |
| System Info | fastfetch | Fast system information tool |
| Process Monitor | btop | Modern replacement for top/htop |

## Directory Structure

```
├── btop/              # btop theme configuration
├── fastfetch/         # fastfetch preset configuration
├── fcitx5/            # Fcitx5 input method configuration
├── fish/              # Fish shell configuration
├── hypr/              # Hyprland configuration
├── kitty/             # Kitty terminal configuration
├── ohmyposh/          # ohmyposh theme
├── scripts/           # Auxiliary scripts
├── shell/             # Base shell configuration
└── systemd/           # System service units
```

## Backup and Restore

The `scripts/` directory contains automation scripts supporting automatic system snapshots and configuration restoration.

## Usage Instructions

### Sync Configuration

Use symbolic links to link configuration files to their respective locations:

```bash
ln -s ~/dotfiles/fish/config.fish ~/.config/fish/config.fish
ln -s ~/dotfiles/hypr/conf ~/.config/hypr/conf
```

### Automatic Restore

Run the restore script to automatically revert configurations:

```bash
./scripts/restore.sh
```

## Dependencies

- Linux distribution (Arch Linux recommended)
- Hyprland
- Fish Shell
- Kitty
- Fcitx5 + Rime
- fastfetch
- btop
- ohmyposh

## License

These configurations are intended solely for personal learning and use. Feel free to reference and adapt them.