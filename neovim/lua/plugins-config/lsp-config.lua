-- ##############################################
-- lua/plugins-config/lsp-config.lua
-- ##############################################
local status_lsp, lspconfig = pcall(require, "lspconfig")
if not status_lsp then return end

local status_mason_lsp, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_mason_lsp then return end

-- 補完のための Capabilities 設定
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- 共通の on_attach 設定
local on_attach = function(client, bufnr)
  -- 保存時の自動フォーマット
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("LspFormat." .. bufnr, { clear = true }),
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end
end

-- ##############################################
-- Mason-LSPConfig の設定 (v2.0 以降の書き方)
-- ##############################################
mason_lspconfig.setup({
  -- 自動インストールするサーバー
  ensure_installed = {
    "ts_ls",
    "tailwindcss",
    "gopls",
    "lua_ls",
  },
  
  -- サーバーごとのセットアップ (旧 setup_handlers の内容をここに書く)
  handlers = {
    -- 1. デフォルトハンドラ (すべてのサーバーに適用)
    function(server_name)
      lspconfig[server_name].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,

    -- 2. 特定のサーバー固有の設定 (サーバー名をキーにする)
    ["lua_ls"] = function()
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
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

-- ##############################################
-- nvim-cmp (補完) の設定 (ここは変更なし)
-- ##############################################
local cmp_status, cmp = pcall(require, "cmp")
if cmp_status then
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
end
