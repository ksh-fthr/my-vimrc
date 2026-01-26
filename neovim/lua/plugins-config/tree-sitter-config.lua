-- ##############################################
-- tree-sitter (plugins-config/tree-sitter-config.lua)
-- ##############################################

-- nvim-treesitter.configs は廃止されたため、直に require("nvim-treesitter") を使用
local status, ts = pcall(require, "nvim-treesitter.configs")

-- もし上記がエラーになる（新バージョン）場合は、トップレベルの setup を試みる
if not status then
  ts = require("nvim-treesitter")
end

ts.setup({
  -- ハイライト機能の有効化
  highlight = {
    enable = true,
    disable = {},
  },
  -- インデント機能の有効化
  indent = {
    enable = true,
    disable = {},
  },
  -- インストールするパーサーの指定
  ensure_installed = {
    "tsx",
    "toml",
    "fish",
    "php",
    "json",
    "yaml",
    "swift",
    "css",
    "html",
    "lua",
    "javascript",
    "typescript",
    "vim",
    "vimdoc", -- Neovimのヘルプ用
    "markdown",
    "markdown_inline"
  },
  -- nvim-ts-autotag との連携
  autotag = {
    enable = true,
  },
})

-- TSXファイルのパーサー設定（最新の推奨される書き方）
vim.treesitter.language.register('typescriptreact', 'tsx')
