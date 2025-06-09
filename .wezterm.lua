local wezterm = require 'wezterm'

-- config_builderを使うとバリデーションが効きます
local config = wezterm.config_builder and wezterm.config_builder() or {}

-- フォントの設定
config.font = wezterm.font_with_fallback({
    "Hack Nerd Font",  
    "Cica",
})

-- フォントサイズの設定
config.font_size = 10

-- カラースキーム
config.color_scheme = "Catppuccin Mocha"  -- 好きなカラースキーム名に変更可

-- ウィンドウの背景透過
config.window_background_opacity = 0.85

-- 起動時にフルスクリーン
local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():toggle_fullscreen()
end)

-- ショートカットキー設定
local act = wezterm.action
config.keys = {
  {
    key = 'f',
    mods = 'SHIFT|META',
    action = act.ToggleFullScreen,
  },
}

-- WSL2 Debian用プロファイルの追加
config.default_prog = { 'wsl.exe', '-d', 'Debian' }

return config

