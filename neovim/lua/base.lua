-- ##############################################
-- base.lua
-- ##############################################
local opt = vim.opt

-- 基本設定
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.title = true
opt.clipboard = "unnamedplus"
opt.number = true
opt.relativenumber = false
opt.cursorline = true
opt.mouse = "a"
opt.termguicolors = true

-- インデント設定
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 4
opt.smartindent = true

-- 検索設定
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true

-- システム設定
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true
opt.timeoutlen = 300
opt.updatetime = 300
opt.scrolloff = 8
opt.signcolumn = "yes"

-- ウィンドウセパレータを見やすく設定
opt.fillchars = {
  vert = "│",
  vertleft = "│",
  vertright = "│",
  horiz = "─",
  horizup = "─",
  horizdown = "─",
}

-- Autocmd グループ
local my_augroup = vim.api.nvim_create_augroup("MyCustomAutocmds", { clear = true })

-- 保存時に行末の空白を削除
vim.api.nvim_create_autocmd("BufWritePre", {
  group = my_augroup,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- カーソル位置の復元
vim.api.nvim_create_autocmd("BufReadPost", {
  group = my_augroup,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

-- 外部でのファイル変更を検知
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  group = my_augroup,
  callback = function()
    if vim.fn.mode() ~= 'c' then vim.cmd('checktime') end
  end,
})

-- ウィンドウセパレータのハイライト設定( カラースキームを読み込み後に設定 )
vim.api.nvim_create_autocmd("ColorScheme", {
  group = my_augroup,
  callback = function()
    -- ウィンドウセパレータを見やすく設定
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#61afef", bold = true })
    vim.api.nvim_set_hl(0, "VerSplit", { fg = "#61afef", bold = true })
  end,
})

-- 初回起動時にも適用
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#61afef", bold = true })
vim.api.nvim_set_hl(0, "VerSplit", { fg = "#61afef", bold = true })
