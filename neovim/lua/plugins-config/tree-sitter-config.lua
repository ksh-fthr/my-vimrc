-- ##############################################
-- Tree-sitter (lua/plugins-config/tree-sitter-config.lua)
-- ##############################################
local status, ts_configs = pcall(require, "nvim-treesitter.configs")
if not status then return end

ts_configs.setup({
  highlight = { enable = true, disable = {} },
  indent = { enable = true, disable = {} },
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
    "vimdoc",
    "markdown",
    "markdown_inline",
    "python",
    "htmldjango",
    "bash",
  },
  autotag = { enable = true },
})

-- パーサー登録の最新形式
vim.treesitter.language.register('typescriptreact', 'tsx')
