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
})

-- キーマップ設定（既存機能保持）
vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', { silent = true })
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', { silent = true })
