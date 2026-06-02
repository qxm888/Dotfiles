-- 自启动程序
-- 旧: exec-once → 新: hl.on("hyprland.start", ...)

hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("waybar")
    hl.exec_cmd("fcitx5")
    hl.exec_cmd("qs -c noctalia-shell")

    -- 剪贴板管理 (cliphist + 智能清空 + 收藏)
    hl.exec_cmd("wl-paste --type text --watch ~/opencode/scripts/cliphist-smart-store.sh")
    hl.exec_cmd("wl-paste --type image --watch ~/opencode/scripts/cliphist-smart-store.sh")
end)
