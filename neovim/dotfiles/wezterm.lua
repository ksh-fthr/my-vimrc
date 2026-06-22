local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- OS判定用の変数
local is_windows = wezterm.target_triple:find("windows") ~= nil
local is_mac = wezterm.target_triple:find("apple") ~= nil

-- ==========================================
-- 共通設定 (Mac / Windows 両方)
-- ==========================================
config.color_scheme = 'Tokyo Night'

-- wezterm のウィンドウ枠の色と幅を設定する
config.window_frame = {
  border_left_color = '#5879cf',
  border_right_color = '#5879cf',
  border_bottom_color = '#5879cf',
  border_top_color = '#5879cf',

  border_left_width = '2px',
  border_right_width = '2px',
  border_bottom_height = '2px',
  border_top_height = '2px',
}

-- ペインの境界線の色を正しく指定する
config.colors = {
  -- split がペイン間の境界線を指す正しいプロパティです
  split = '#5879cf', -- 境界線の色（Tokyo Nightの鮮やかな青）
}

-- 境界線の太さを設定する（デフォルトの1pxから太くする）
-- ※ WezTermではここ（window_padding）を調整することで境界線の見え方が変わります
config.window_padding = {
  left = '2cell',
  right = '2cell',
  top = '1cell',
  bottom = '1cell',
}

-- 非アクティブなペインを暗くして、どこを選択しているか分かりやすくする
config.inactive_pane_hsb = {
  brightness = 0.4,
  saturation = 0.7,
}

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

-- タブバー: 誤操作で閉じないように幅を広げる
config.tab_max_width = 32
config.hide_tab_bar_if_only_one_tab = false
config.window_close_confirmation = 'AlwaysPrompt'

-- タブ幅を常に固定する
local FIXED_TAB_WIDTH = 32
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local title = tab.tab_title
  if title == nil or #title == 0 then
    title = tab.active_pane.title
  end

  -- 左右に1スペースのパディングを確保した上で固定幅にする
  local inner = FIXED_TAB_WIDTH - 2
  if wezterm.column_width(title) > inner then
    title = wezterm.truncate_right(title, inner - 1) .. '…'
  else
    title = title .. string.rep(' ', inner - wezterm.column_width(title))
  end
  return ' ' .. title .. ' '
end)

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
