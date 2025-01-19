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
  on_attach = on_attach,
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
  on_attach = on_attach,
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

local keymap = vim.keymap.set

-- 定義にジャンプ
keymap('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true })

-- 型定義にジャンプ
keymap('n', 'gt', vim.lsp.buf.type_definition, { noremap = true, silent = true })

-- 参照を表示
keymap('n', 'gr', vim.lsp.buf.references, { noremap = true, silent = true })

-- ドキュメントの表示
keymap('n', 'K', vim.lsp.buf.hover, { noremap = true, silent = true })

-- コードアクションを実行するキーマッピング
keymap('n', 'ca', vim.lsp.buf.code_action, { noremap = true, silent = true })

-- リネームを実行するキーマッピング
keymap('n', 'rn', vim.lsp.buf.rename, { noremap = true, silent = true })

-- 現在行の診断情報を表示するためのキーマッピング(なぜかこいつエラーになるのでコメントアウトしておく)
-- keymap('n', 'sl', vim.lsp.diagnostic.show_line_diagnostics, { noremap = true, silent = true })

-- 現在のカーソル位置に関連する診断情報をポップアップで表示
keymap('n', 'sc', vim.diagnostic.open_float, { noremap = true, silent = true })

-- バッファ内のすべての診断情報をクイックフィックスリストに表示
keymap('n', 'sb', function()
  -- 診断情報の表示方法をカスタマイズ
  vim.diagnostic.config({
    virtual_text = true,           -- 仮想テキストとして診断メッセージを行内に表示
    signs = true,                  -- 診断アイコンを表示
    update_in_insert = false,      -- 挿入モード中に診断を更新しない
    underline = true,              -- 診断がある箇所をアンダーラインで表示
    severity_sort = true,          -- 診断の重大度に基づいて並べ替え
  })

  -- バッファ内の診断情報をクイックフィックスリストにセット
  vim.diagnostic.setqflist()

  -- クイックフィックスリストを開く
  vim.cmd('copen')
end, { noremap = true, silent = true })

-- 前の診断情報にジャンプ
keymap('n', 'cp', vim.diagnostic.goto_prev, { noremap = true, silent = true })

-- 次の診断情報にジャンプ
keymap('n', 'cn', vim.diagnostic.goto_next, { noremap = true, silent = true })

-- 前のエラー診断にジャンプ
keymap('n', '[e', function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { noremap = true, silent = true })

-- 次のエラー診断にジャンプ
keymap('n', ']e', function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { noremap = true, silent = true })

-- バッファ内のシンボルをクイックフィックスリストに表示
keymap('n', 'ol', function()
  vim.lsp.buf.document_symbol()  -- 現在のバッファのシンボルを取得

  -- シンボルをクイックフィックスリストに追加
  vim.cmd('copen')  -- クイックフィックスリストを開く
end, { noremap = true, silent = true })

-- 現在カーソル位置の関数の呼び出し元を表示
keymap('n', 'ci', function()
  vim.lsp.buf.incoming_calls()  -- 現在の関数の呼び出し元を取得して表示
end, { noremap = true, silent = true })

-- 現在カーソル位置の関数の呼び出し先を表示
keymap('n', 'co', function()
  vim.lsp.buf.outgoing_calls()  -- 現在の関数の呼び出し先を取得して表示
end, { noremap = true, silent = true })

-- ターミナルを使う
-- akinsho/toggleterm.nvim プラグインを使う
require("toggleterm").setup{
  open_mapping = [[<c-\>]],  -- Ctrl + \ でターミナルをトグル
  size = 20,                 -- ターミナルウィンドウの高さ
  direction = 'float',  -- ターミナルの表示方向（horizontal, vertical, float）
}

-- ターミナルをトグルするためのキーバインディング
keymap('n', 'tt', '<cmd>ToggleTerm<CR>', { noremap = true, silent = true })
