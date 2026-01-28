-- ##############################################
-- lua/plugins-config/lsp-config.lua
-- ##############################################
local m_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local cmp_lsp = require("cmp_nvim_lsp")
local cmp = require("cmp")

-- 補完機能を LSP に通知 (警告回避のため最新の関数を使用)
local capabilities = cmp_lsp.default_capabilities()

-- 共通のオンアタッチ設定 (自動フォーマットを保持)
local on_attach = function(client, bufnr)
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("LspFormat." .. bufnr, { clear = true }),
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr, async = false })
      end,
    })
  end
end

-- Mason-LSPConfig セットアップ
m_lspconfig.setup({
  ensure_installed = { "ts_ls", "tailwindcss", "gopls", "lua_ls" },
  handlers = {
    function(server_name)
      lspconfig[server_name].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
    ["lua_ls"] = function()
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false, library = vim.api.nvim_get_runtime_file("", true) },
          },
        },
      })
    end,
    ["ts_ls"] = function()
      lspconfig.ts_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
      })
    end,
  },
})

-- nvim-cmp の設定 (マッピング・ソース・スニペット設定を完全復元)
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "copilot" },
    { name = "nvim_lsp" },
    { name = "vsnip" },
  }, {
    { name = "buffer" },
  }),
})
