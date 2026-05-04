local wezterm = require("wezterm")
local module = {}

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
  
  if string.find(target_triple, "linux") and is_wsl() then
    -- WSL用設定（Linuxターゲットだが、WSL環境）
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

function module.apply_to_config(config)
  -- クリップボード関連の基本設定
  config.selection_word_boundary = " \t\n{}[]()\"'`"
  
  -- Note: clipboard behavior is typically handled through key bindings
  -- rather than direct config fields in modern WezTerm versions
end

return module