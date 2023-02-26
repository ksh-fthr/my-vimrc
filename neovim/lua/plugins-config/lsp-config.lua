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
      callback = function() vim.lsp.buf.formatting_seq_sync() end
    })
  end
end

-- TypeScript
-- 事前準備
-- * `npm install -g typescript typescript-language-server` を実行しておく
nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  init_options = {
    hostInfo = "neovim"
  },
  -- root_dir = nvim_lsp.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
  cmd = { "typescript-language-server", "--stdio" }
}

-- tailwind css
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

-- go lang
-- 事前準備
-- * `go install github.com/nametake/golangci-lint-langserver@latest` を実行しておく
-- * `go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest` を事項しておく
-- nvim_lsp.golangci_lint_ls.setup {
--   cmd = { "golangci-lint-langserver" },
--   filetypes = { "go", "gomod" },
--   init_options = {
--     command = { "golangci-lint", "run", "--out-format", "json" }
--   },
--   -- root_dir = nvim_lsp.util.root_pattern('go.work') or root_pattern('go.mod', '.golangci.yaml', '.git')
-- }

nvim_lsp.gopls.setup {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  -- root_dir = nvim_lsp.util.root_pattern("go.mod", ".git")
}

-- 1. LSP Sever management
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

-- 2. build-in LSP function
-- keyboard shortcut
vim.keymap.set('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
-- LSP handlers
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)

-- 3. completion (hrsh7th/nvim-cmp)
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


