-- ##############################################
-- Lsp Config
-- ##############################################

local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")

-- 1. 共通設定 (Capabilities & on_attach)
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(client, bufnr)
  -- 保存時に自動フォーマット
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

-- 2. Mason LSPConfig Setup
mason_lspconfig.setup({
  ensure_installed = {
    "ts_ls",
    "tailwindcss",
    "gopls",
    "lua_ls",
  },
  handlers = {
    -- デフォルトハンドラ
    function(server_name)
      lspconfig[server_name].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,

    -- Lua 固有の設定
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

    -- TypeScript 固有の設定
    ["ts_ls"] = function()
      lspconfig.ts_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
      })
    end,
  }
})

-- 3. nvim-cmp Setup (補完)
local cmp_status, cmp = pcall(require, "cmp")
if cmp_status then
  local lspkind_status, lspkind = pcall(require, "lspkind")
  
  local formatting_config = {}
  if lspkind_status then
    formatting_config = {
      format = lspkind.cmp_format({
        mode = "symbol",
        max_width = 50,
        symbol_map = { Copilot = "" }
      })
    }
  end

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-l>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = "copilot", group_index = 2 },
      { name = "nvim_lsp", group_index = 2 },
      { name = "vsnip", group_index = 2 },
      { name = "nvim_lsp_signature_help" },
    }, {
      { name = "buffer" },
    }),
    formatting = formatting_config,
    experimental = {
      ghost_text = true,
    },
  })
end

-- 4. 診断表示の設定 (Diagnostics)
vim.diagnostic.config({
  virtual_text = false, -- 行末のテキスト表示をオフ
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- 5. キーマッピング
local keymap = vim.keymap.set

keymap('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true })
keymap('n', 'gt', vim.lsp.buf.type_definition, { noremap = true, silent = true })
keymap('n', 'gr', vim.lsp.buf.references, { noremap = true, silent = true })
keymap('n', 'K', vim.lsp.buf.hover, { noremap = true, silent = true })
keymap('n', 'ca', vim.lsp.buf.code_action, { noremap = true, silent = true })
keymap('n', 'rn', vim.lsp.buf.rename, { noremap = true, silent = true })
keymap('n', 'sc', vim.diagnostic.open_float, { noremap = true, silent = true })
keymap('n', 'cp', vim.diagnostic.goto_prev, { noremap = true, silent = true })
keymap('n', 'cn', vim.diagnostic.goto_next, { noremap = true, silent = true })

-- Go 向けの保存時自動処理
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({async = false})
  end
})
