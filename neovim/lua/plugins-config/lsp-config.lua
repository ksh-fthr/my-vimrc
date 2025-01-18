-- ##############################################
-- Lsp Config
-- ##############################################
local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end

local protocol = require('vim.lsp.protocol')

local on_attach = function(client, bufnr)
  -- format on save
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("Format", { clear = true }),
      buffer = bufnr,
      callback = function() vim.lsp.buf.format() end
    })
  end
end

-- ---------------------------------
-- TypeScript
-- ---------------------------------
-- 事前準備
-- * `npm install -g typescript typescript-language-server` を実行しておく
nvim_lsp.ts_ls.setup {
  on_attach = on_attach,
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  init_options = {
    hostInfo = "neovim"
  },
  -- root_dir = nvim_lsp.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
  cmd = { "typescript-language-server", "--stdio" }
}

-- ---------------------------------
-- tailwind css
-- ---------------------------------
nvim_lsp.tailwindcss.setup {
  cmd = { "tailwindcss-language-server", "--stdio" },
  init_options = {
    userLanguages = {
      eelixir = "html-eex",
      eruby = "erb"
    }
  },
  -- root_dir = nvim_lsp.util.root_pattern('tailwind.config.js', 'tailwind.config.ts', 'postcss.config.js', 'postcss.config.ts', 'package.json', 'node_modules', '.git')
}

-- ---------------------------------
-- go lang
-- ---------------------------------
nvim_lsp.gopls.setup {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  -- root_dir = nvim_lsp.util.root_pattern("go.mod", ".git")
}

-- 保存時にフォーマットをかける
-- Use the following configuration to have your imports organized on save using the logic of goimports and your code formatted.
-- 参考: https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-imports
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    vim.opt.tabstop = 4
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
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

-- ---------------------------------
-- LSP Sever management
-- ---------------------------------
require('mason').setup()
require('mason-lspconfig').setup_handlers({ function(server)
  local opt = {
  -- -- Function executed when the LSP server startup
  -- on_attach = function(client, bufnr)
  --   local opts = { noremap=true, silent=true }
  --   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  --   vim.cmd 'autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000)'
  -- end,
  capabilities = require('cmp_nvim_lsp').default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  )}
  require('lspconfig')[server].setup(opt)
end })

-- ---------------------------------
-- LSP handlers
-- ---------------------------------
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)

-- ---------------------------------
-- completion (hrsh7th/nvim-cmp)
-- ---------------------------------
local cmp = require("cmp")
cmp.setup({
  snippet = {
  expand = function(args)
    vim.fn["vsnip#anonymous"](args.body)
  end,
  },
  sources = {
  { name = "nvim_lsp" },
  -- { name = "buffer" },
  -- { name = "path" },
  },
  mapping = cmp.mapping.preset.insert({
  ["<C-p>"] = cmp.mapping.select_prev_item(),
  ["<C-n>"] = cmp.mapping.select_next_item(),
  ['<C-l>'] = cmp.mapping.complete(),
  ['<C-e>'] = cmp.mapping.abort(),
  ["<CR>"] = cmp.mapping.confirm { select = true },
  }),
  experimental = {
    ghost_text = true,
  },
})

