-- 自启动程序
-- 旧: exec-once → 新: hl.on("hyprland.start", ...)

hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user start graphical-session.target")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    --hl.exec_cmd("hyprpaper")  -- 壁纸改由 Noctalia 管理
    --hl.exec_cmd("bash -c 'sleep 1 && ~/.config/waybar/scripts/wallpaper-switch.sh'")
    --hl.exec_cmd("waybar")
    --hl.exec_cmd("swaync")
    hl.exec_cmd("fcitx5")
    hl.exec_cmd("noctalia")

    -- 剪贴板管理 (cliphist + 智能清空 + 收藏)
    hl.exec_cmd("wl-paste --type text --watch ~/opencode/scripts/cliphist-smart-store.sh")
    hl.exec_cmd("wl-paste --type image --watch ~/opencode/scripts/cliphist-smart-store.sh")
end)
