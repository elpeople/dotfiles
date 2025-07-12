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
config.window_background_opacity = 0.75

-- 起動時にフルスクリーン
--local mux = wezterm.mux
--wezterm.on("gui-startup", function(cmd)
--  local tab, pane, window = mux.spawn_window(cmd or {})
--  window:gui_window():toggle_fullscreen()
--end)

-- OS別のクリップボード設定
local function get_clipboard_config()
  local target_triple = wezterm.target_triple
  
  -- WSL環境の判定
  local function is_wsl()
    local handle = io.popen("uname -r 2>/dev/null")
    if handle then
      local result = handle:read("*a")
      handle:close()
      return string.find(result:lower(), "microsoft") or string.find(result:lower(), "wsl")
    end
    return false
  end
  
  if string.find(target_triple, "windows") and is_wsl() then
    -- WSL用設定（Windowsホスト上のWSL）
    return {
      copy_to_clipboard = "Clipboard",
      paste_from_clipboard = "Clipboard",
      -- WSL特有の設定
      enable_wayland = false,
    }
  elseif string.find(target_triple, "linux") then
    -- ネイティブLinux用設定
    return {
      copy_to_clipboard = "ClipboardAndPrimarySelection",
      paste_from_clipboard = "Clipboard",
    }
  elseif string.find(target_triple, "apple") then
    -- macOS用設定
    return {
      copy_to_clipboard = "Clipboard",
      paste_from_clipboard = "Clipboard",
    }
  elseif string.find(target_triple, "windows") then
    -- ネイティブWindows用設定
    return {
      copy_to_clipboard = "Clipboard", 
      paste_from_clipboard = "Clipboard",
    }
  else
    -- デフォルト設定
    return {
      copy_to_clipboard = "Clipboard",
      paste_from_clipboard = "Clipboard",
    }
  end
end

-- クリップボード設定を適用
local clipboard_config = get_clipboard_config()
config.selection_word_boundary = " \t\n{}[]()\"'`"
config.copy_mode_active_highlight_bg = { Color = "#000000" }
config.copy_mode_active_highlight_fg = { AnsiColor = "Black" }
config.copy_mode_inactive_highlight_bg = { Color = "#52ad70" }
config.copy_mode_inactive_highlight_fg = { Color = "#c0c0c0" }

-- OS別クリップボード設定を適用
for key, value in pairs(clipboard_config) do
  config[key] = value
end

-- ショートカットキー設定
local act = wezterm.action
config.keys = {
  {
    key = 'f',
    mods = 'SHIFT|META',
    action = act.ToggleFullScreen,
  },
  -- クリップボード関連のキーバインド
  {
    key = 'c',
    mods = 'CTRL|SHIFT',
    action = act.CopyTo 'Clipboard',
  },
  {
    key = 'v',
    mods = 'CTRL|SHIFT', 
    action = act.PasteFrom 'Clipboard',
  },
}

-- WSL2 Debian用プロファイルの追加
-- config.default_prog = { 'wsl.exe', '-d', 'Debian' }

return config

