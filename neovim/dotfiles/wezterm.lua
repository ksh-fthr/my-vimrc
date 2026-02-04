local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- OS判定用の変数
local is_windows = wezterm.target_triple:find("windows") ~= nil
local is_mac = wezterm.target_triple:find("apple") ~= nil

-- ==========================================
-- 共通設定 (Mac / Windows 両方)
-- ==========================================
config.color_scheme = 'Tokyo Night'

-- ビープ音を無効化（何もしない）
config.audible_bell = "Disabled"

-- (オプション) 音の代わりに画面を一瞬光らせたい場合はこちら
-- config.visual_bell = {
--   fade_in_function = 'Linear',
--   fade_in_duration_ms = 75,
--   fade_out_function = 'Linear',
--   fade_out_duration_ms = 75,
-- }

-- 日本語入力を安定させる
config.use_ime = true
config.scrollback_lines = 10000

-- ==========================================
-- Windows (WSL2) 用の設定
-- ==========================================
if is_windows then
  config.default_domain = 'WSL:Ubuntu-24.04'
  config.initial_cols = 200
  config.initial_rows = 50

  -- Windows用のフォント指定
  config.font_size = 12.0
  config.font = wezterm.font_with_fallback({
    { family = 'HackGen Console NF' },
    { family = 'JetBrains Mono' },
    { family = 'Segoe UI Emoji' },
  })

  -- Windows特有の見た目（背景透過など）
  config.window_background_opacity = 0.9
  config.win32_system_backdrop = 'Acrylic'

  -- キーバインドの設定
  config.keys = {
    { key = 'v', mods = 'CTRL|SHIFT', action = wezterm.action.PasteFrom 'Clipboard' },
    { key = 'c', mods = 'CTRL|SHIFT', action = wezterm.action.CopyTo 'Clipboard' },
    { key = 'k', mods = 'CTRL|SHIFT', action = wezterm.action.ClearScrollback 'ScrollbackAndViewport' },
  }
end

-- ==========================================
-- Mac (M4 Mac mini) 用の設定
-- ==========================================
if is_mac then
  -- Macはデフォルトで zsh 等が起動するので domain 指定は不要なことが多いです
  config.initial_cols = 200
  config.initial_rows = 50

  -- Mac用のフォント指定（Mac側にインストールしている名前に合わせる）
  config.font_size = 16.0
  config.font = wezterm.font_with_fallback({
    { family = 'HackGen Console NF' },
    { family = 'Apple Color Emoji' },
  })

  -- Mac特有の見た目
  config.macos_window_background_blur = 20
  config.window_background_opacity = 0.85

  -- キーバインドの設定
  config.keys = {
    { key = 'v', mods = 'CMD', action = wezterm.action.PasteFrom 'Clipboard' },
    { key = 'c', mods = 'CMD', action = wezterm.action.CopyTo 'Clipboard' },
    { key = 'k', mods = 'CMD', action = wezterm.action.ClearScrollback 'ScrollbackAndViewport' },
  }
end

return config
