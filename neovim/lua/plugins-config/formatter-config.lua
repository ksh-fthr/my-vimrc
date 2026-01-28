-- ##############################################
-- lua/plugins-config/formatter-config.lua
-- ##############################################

local status_null, null_ls = pcall(require, "null-ls")
if status_null then
  null_ls.setup({
    sources = {
      -- 8行目の設定内容を完全保持
      null_ls.builtins.diagnostics.eslint_d.with({
        diagnostics_format = '[eslint] #{m}\n(#{c})'
      }),
      null_ls.builtins.diagnostics.fish
    }
  })
end

-- prettierの設定を完全保持
local status_prettier, prettier = pcall(require, "prettier")
if status_prettier then
  prettier.setup {
    bin = 'prettierd',
    filetypes = {
      "css",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "json",
      "scss",
      "less"
    }
  }
end
