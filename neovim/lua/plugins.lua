-- ##############################################
-- lua/plugins.lua (全機能保持リファクタリング版)
-- ##############################################
return {
  -- ユーティリティ
  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-web-devicons" },

  -- 見た目・テーマ
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    config = function() vim.cmd("colorscheme nightfox") end,
  },
  { "nvim-lualine/lualine.nvim", config = function() require("plugins-config/status-line-config") end },
  { "akinsho/bufferline.nvim",   config = function() require("plugins-config/tab-config") end },

  -- LSP / Mason 統合
  {
    "neovim/nvim-lspconfig",
    -- event に "VeryLazy" を追加することで、ファイルを開かなくても
    -- 起動直後にバックグラウンドで読み込まれ、コマンドが登録されます。
    event = { "BufReadPre", "BufNewFile", "VeryLazy" },
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("plugins-config/lsp-config")
      -- lspsaga-keymap-config がある場合は読み込む
      pcall(require, "plugins-config/lspsaga-keymap-config")
    end,
  },

  -- 補完エンジン
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-vsnip", "hrsh7th/vim-vsnip",
      "hrsh7th/cmp-cmdline",                 -- コマンドライン補完
      "hrsh7th/cmp-nvim-lua",                -- Neovim Lua API 補完
      "hrsh7th/cmp-nvim-lsp-signature-help", -- 関数シグネチャヘルプ
      "onsails/lspkind.nvim",
      "L3MON4D3/LuaSnip",                    -- 高機能スニペットエンジン
      "saadparwaiz1/cmp_luasnip",            -- LuaSnip とcmp の連携
      { "zbirenbaum/copilot-cmp", config = function() require("copilot_cmp").setup() end },
    },
  },

  -- 編集補助
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end
  },
  { "tomtom/tcomment_vim" },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
      require("plugins-config/formatter-config")
    end
  },

  -- Git
  { "lewis6991/gitsigns.nvim", config = function() require("plugins-config/git-config") end },
  { "dinhhuy258/git.nvim" },

  -- Fern (自動起動・レンダラー設定を保持)
  {
    "lambdalisue/fern.vim",
    dependencies = {
      "lambdalisue/nerdfont.vim",
      "lambdalisue/fern-renderer-nerdfont.vim",
      "lambdalisue/glyph-palette.vim",
      "lambdalisue/fern-git-status.vim",
      "LumaKernel/fern-mapping-reload-all.vim", -- 全リロード機能
      "yuki-yano/fern-preview.vim",             -- プレビュー機能
    },
    config = function()
      vim.cmd("autocmd VimEnter * ++nested Fern . -drawer -stay -keep -toggle -reveal=%")
      vim.g["fern#default_hidden"] = 1
      vim.g["fern#renderer"] = "nerdfont"

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "fern",
        callback = function()
          vim.fn["glyph_palette#apply"]()

          -- Fern 拡張プラグインのキーマップ設定
          local opts = { buffer = true, silent = true, noremap = false }
          vim.keymap.set('n', 'p', '<Plug>(fern-action-preview:toggle)', opts)
          vim.keymap.set('n', '<C-p>', '<Plug>(fern-action-preview:auto:toggle)', opts)
          vim.keymap.set('n', '<C-d>', '<Plug>(fern-action-preview:scroll:down:half)', opts)
          vim.keymap.set('n', '<C-u>', '<Plug>(fern-action-preview:scroll:up:half)', opts)
          vim.keymap.set('n', 'R', '<Plug>(fern-action-reload:all)', opts)
        end
      })
    end,
  },

  -- AI & Terminal (プロンプト・キーマップを完全保持)
  -- Copilot 本体 ( copilot-cmp との競合を防ぐため suggestion/panel は無効化 )
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false }, -- copilot-cmp を使うため無効化
        panel = { enabled = false },      -- copilot-cmp を使うため無効化
      })
    end
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    build = "make install",
    dependencies = { "zbirenbaum/copilot.lua", "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
    opts = {
      system_prompt =
      "あなたは有能なエンジニアです。回答は必ず日本語で行い、コードの修正案は必ずMarkdownのコードブロック形式で記述してください。返答の冒頭に挨拶や承諾の言葉は不要です。すぐにコードを出力してください。今のバッファを直接書き換えることはできないので、必ずこのチャット欄に修正後の全コードを提示してください。",
      language = "Japanese",
      window = { layout = 'float', side = 'right', width = 0.4, height = 0.9, relative = 'editor', row = 1, col = vim.o.columns },
      show_help = false,
      mappings = { diff = { normal = '<C-d>' } },
    },
    keys = {
      { "<leader>cc", "<cmd>CopilotChatOpen<cr>",   desc = "Chat Open" },
      { "<leader>ct", "<cmd>CopilotChatToggle<cr>", desc = "Chat Toggle" },
      { "<leader>cr", "<cmd>CopilotChatReset<cr>",  desc = "Chat Reset" },
      {
        "<leader>ca",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
        end,
        desc = "Chat Actions"
      },
    },
  },

  -- ターミナル ( Claude Code 用 )
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    -- lazy.vim のトリガー設定
    keys = {
      { "<C-t>", desc = "Terminal Right" },
      { "<C-b>", desc = "Terminal Bottom" },
    },
    config = function() require("plugins-config/toggle-term-config") end,
  },

  -- Search & Syntax
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim", -- ファイルブラウザ拡張
    },
    config = function()
      require("plugins-config/telescope-config")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag"
    },
    config = function()
      require("plugins-config/tree-sitter-config")
      require("plugins-config/auto-tag-config")
    end,
  },
  { "sindrets/diffview.nvim" },

  -- python サポート
  {
    "linux-cultist/venv-selector.nvim", -- 仮想環境自動切り替え
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
    },
    ft = "python",
    config = function()
      require("venv-selector").setup({
        -- デフォルト設定のまま
      })
    end,
    keys = {
      { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select Python Virtualenv" },
    },
  },

  -- 言語サポート
  {
    "evanleck/vim-svelte",
    ft = "svelte",
  },

  -- デバッグ環境( DAP )
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",            -- DAP UI
      "theHamsta/nvim-dap-virtual-text", -- 仮想テキスト表示
      "nvim-neotest/nvim-nio",           -- 非同期 I/O ( nvim-dap-ui の依存関係 )
    },
    keys = {
      { "<leader>db", "<cmd>DapToggleBreakpoint<cr>",           desc = "Toggle Breakpoint" },
      { "<leader>dc", "<cmd>DapContinue<cr>",                   desc = "Continue" },
      { "<leader>di", "<cmd>DapStepInto<cr>",                   desc = "Into" },
      { "<leader>do", "<cmd>DapStepOver<cr>",                   desc = "Step Over" },
      { "<leader>dO", "<cmd>DapStepOut<cr>",                    desc = "Step Out" },
      { "<leader>dt", "<cmd>DapTerminate<cr>",                  desc = "Terminate" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      -- 仮想テキスト検証
      require("nvim-dap-virtual-text").setup()

      -- DAP イベントに合わせて UI を自動開閉
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  -- GO デバッグサポート
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("plugins-config/dap-go-config").setup()
    end,
  },

  -- Go テスト & タグサポート
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-go", -- GO テストアダプター
    },
    ft = "go",
    keys = {
      { "<leader>tt", function() require("neotest").run.run() end,                     desc = "Run Neotest" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end,   desc = "Run Neotest File" },
      { "<leader>ts", function() require("neotest").summary.toggle() end,              desc = "Toggle Neotest Summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Open Neotest Output" },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-go")({
            experimental = {
              test_table = true,                   -- テーブル駆動テスト対応
            },
            args = { "-count=1", "-timeout=60s" }, -- テスト実行時の引数
          }),
        },
      })
    end,
  },

  -- Go struct tag 管理
  {
    "fatih/vim-go",
    ft = "go",
    build = ":GoUpdateBinaries",
    config = function()
      -- LSP を使うため vim-go の LSP 機能は無効化
      vim.g.go_def_mapping_enabled = 0
      vim.g.go_code_completion_enabled = 0
      vim.g.gopls_enabled = 0

      -- struct tag 関連機能のみ有効化
      vim.g.go_addtags_transform = "camelcase"
      vim.g.go_highlight_types = 1
      vim.g.go_highlight_fields = 1
      vim.g.go_highlight_functions = 1
      vim.g.go_highlight_function_calls = 1
      vim.g.go_highlight_operators = 1
      vim.g.go_highlight_extra_types = 1
    end,
  }
}
