-- ##############################################
-- lua/plugins-config/formatter-config.lua
-- ##############################################
local status, null_ls = pcall(require, "null-ls")
if not status then return end

null_ls.setup({
  sources = {
    -- 1. [修正] eslint_d は extras から読み込む (機能を完全保持)
    require("none-ls.diagnostics.eslint_d").with({
      diagnostics_format = '[eslint] #{m}\n(#{c})'
    }),

    -- 2. fish 診断
    null_ls.builtins.diagnostics.fish,

    -- 3. フォーマッタ (prettierd)
    null_ls.builtins.formatting.prettierd.with({
      filetypes = {
        "javascript",
        "typescript",
        "typescriptreact",
        "javascriptreact",
        "json",
        "yaml",
        "markdown",
        "html",
        "css",
        "scss",
      }
    }),

    -- 4. Lua / Shell 整形
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.shfmt,
  },
})
