-- ##############################################
-- lua/plugins-config/lsp-config.lua
-- ##############################################
local m_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local cmp_lsp = require("cmp_nvim_lsp")
local cmp = require("cmp")

-- 補完機能を LSP に通知
local capabilities = cmp_lsp.default_capabilities()

-- ##############################################
-- 1. [最新のやり方] 共通のオンアタッチ設定 (LspAttach イベント)
-- ##############################################
-- これにより、どのサーバーの setup にも on_attach を渡す必要がなくなります。
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local bufnr = ev.buf

    -- 保存時の自動フォーマット (以前の機能を完全保持)
    if client and client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("LspFormat." .. bufnr, { clear = true }),
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, async = false })
        end,
      })
    end
  end,
})

-- ##############################################
-- 2. Mason-LSPConfig セットアップ
-- ##############################################
m_lspconfig.setup({
  ensure_installed = {
    "ts_ls",
    "tailwindcss",
    "angularls",
    "html",
    "cssls",
    "pyright",
    "gopls",
    "lua_ls",

  },
  handlers = {
    -- デフォルトセットアップ (on_attach の渡しが不要になりスッキリ)
    function(server_name)
      lspconfig[server_name].setup({
        capabilities = capabilities,
      })
    end,

    -- 特定サーバーの個別設定
    ["lua_ls"] = function()
      lspconfig.lua_ls.setup({
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
        capabilities = capabilities,
        filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
      })
    end,

    ["angularls"] = function()
      lspconfig.angularls.setup({
        capabilities = capabilities,
        filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
        root_dir = lspconfig.util.root_pattern("angular.json", "package.json", ".git"),
      })
    end,

    ["html"] = function()
      lspconfig.html.setup({
        capabilities = capabilities,
        filetypes = { "html", "htmldjango" },
      })
    end,

    ["pyright"] = function()
      lspconfig.pyright.setup({
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      })
    end,

    ["gopls"] = function()
      lspconfig.gopls.setup({
        capabilities = capabilities,
        settings = {
          gopls = {
            -- 解析設定
            analyses = {
              unusedparams = true, -- 未使用パラメータの検出
              shadow = true,       -- シャドウウィング変数の検出
              nilness = true,      -- nil チェック
              unusedwrite = true,  -- 未使用の書き込み検出
              usesany = true,      -- interface() の使用検出
            },
            -- 静的チェック
            staticcheck = true,
            -- コードレンズ( テスト実行、ベンチマークなど )
            codelenses = {
              gc_details = true,         -- ガベージコレクションの詳細
              generate = true,           -- go generate コマンド
              regenerate_cgo = true,     -- cgo の再生成
              test = true,               -- テストの実行
              tidy = true,               -- go mod tidy
              upgrade_dependency = true, -- 依存関係のアップグレード
              vendor = true,             -- ベンダリング
            },
            -- インレイヒント
            hints = {
              assignVariableTypes = true,  -- 変数型の表示
              compositeLiteralFields = true, -- 構造体フィールドの表示
              compositeLiteralTypes = true, -- 複合リテラル型の表示
              constantValues = true,       -- 定数値の表示
              functionTypeParameters = true, -- 関数型パラメータの表示
              parameterNames = true,       -- パラメータ名の表示
              rangeVariableTypes = true,   -- range 変数型の表示
            },
            -- セマンティックトークン
            semanticTokens = true,
            -- 未使用プレースホルダーの扱い
            usePlaceholders = true,
            -- ビルドフラグ
            buildFlags = { "-tags=integration" },
          },
        }
      })
    end,
  },
})

-- ##############################################
-- 3. nvim-cmp の設定 (マッピング・ソース・スニペット設定を完全保持)
-- ##############################################
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
