-- ##############################################
-- lua/plugins-config/formatter-config.lua
-- ##############################################
local status, null_ls = pcall(require, "null-ls")
if not status then return end

null_ls.setup({
  sources = {

    -- JavaScript / TypeScript Linting and Formatting
    require("none-ls.diagnostics.eslint_d").with({
      diagnostics_format = '[eslint] #{m}\n(#{c})'
    }),


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

    -- Python Formatting
    null_ls.builtins.formatting.black, -- Python フォーマッター
    null_ls.builtins.diagnostics.ruff, -- 高速 Python Linter

    -- Otherwise
    null_ls.builtins.diagnostics.fish,   -- fish 診断
    null_ls.builtins.formatting.stylua, -- Lua 整形
    null_ls.builtins.formatting.shfmt,  -- Shell 整形
  },
})
