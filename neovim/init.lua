-- ##############################################
-- init.lua
-- ##############################################
-- 新しいウィンドウを常に右側に開くようにする
vim.opt.splitright = true

vim.opt.shell = "/bin/bash"
vim.opt.splitright = true

-- 基本設定とキーマップ
require("base")
require("keymaps")

-- lazy.nvim のブートストラップ
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- プラグインの管理
-- lua/plugins.lua を読み込みます
require("lazy").setup("plugins", {
    defaults = { lazy = false }, -- 確実にロードさせるため一度 false
    ui = { border = "rounded"},
    performance = {
        rtp = {
            disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
        },
    },
})

-- Fern のグローバル設定 (プラグインロード外の設定)
vim.g["fern#renderer"] = "nerdfont"
vim.g["fern#default_hidden"] = 1
