-- ##############################################
-- init.lua
-- ##############################################
-- 警告(deprecated)対策: 古い関数を新しい標準関数へマッピング
-- これにより、null-ls内部の古い呼び出しがエラーにならず、かつ警告も出なくなります。
vim.tbl_add_reverse_lookup = function(tbl)
  for k, v in pairs(tbl) do tbl[v] = k end
end

-- リーダーキーを Space に設定 (プラグイン読み込み前に必須)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 基本オプション (split系はここに集約)
vim.opt.splitright = true
vim.opt.splitbelow = true

-- 外部設定の読み込み
require("base")
require("keymaps")

-- lazy.nvim ブートストラップ
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- プラグインセットアップ
require("lazy").setup("plugins", {
  defaults = { lazy = false },
  ui = { border = "rounded" },
  performance = {
    rtp = { disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" } },
  },
})

-- プラグイン外のグローバル設定
vim.g["fern#renderer"] = "nerdfont"
vim.g["fern#default_hidden"] = 1
