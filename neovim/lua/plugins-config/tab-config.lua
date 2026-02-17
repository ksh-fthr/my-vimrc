-- ##############################################
-- タブ: Bufferline (lua/plugins-config/tab-config.lua)
-- ##############################################
local status, bufferline = pcall(require, "bufferline")
if not status then return end

bufferline.setup({
  options = {
    mode = "tabs",
    separator_style = 'slant',
    always_show_bufferline = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    color_icons = true
  },
  highlights = {
    -- アクティブなタブ
    tab_selected = {
      fg = '#1e1e1e',
      bg = '#e5c07b',
      bold = true,
    },
    buffer_selected = {
      fg = '#1e1e1e',
      bg = '#e5c07b',
      bold = true,
      italic = false,
    },
    -- 非アクティブなタブ
    tab = {
      fg = '#848b98',
      bg = '#2c323c',
    },
    background = {
      fg = '#848b98',
      bg = '#2c323c',
    },
    -- セパレーター
    separator_selected = {
      fg = '#4b5263',
      bg = '#e5c07b',
    },
    separator = {
      fg = '#4b5263',
      bg = '#2c323c',
    },
    -- タブバー全体の背景
    fill = {
      bg = '#1e2127',
    },
  },
})

-- キーマップ設定（既存機能保持）
vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', { silent = true })
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', { silent = true })
