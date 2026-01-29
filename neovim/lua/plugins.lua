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
  { "windwp/nvim-autopairs",           config = function() require("nvim-autopairs").setup({}) end },
  { "tomtom/tcomment_vim" },
  { "norcalli/nvim-colorizer.lua",     config = function() require("colorizer").setup() end },
  { "jose-elias-alvarez/null-ls.nvim", config = function() require("plugins-config/formatter-config") end },

  -- Git
  { "lewis6991/gitsigns.nvim",         config = function() require("plugins-config/git-config") end },
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
      { "<C-t>", desc = "Terminal" },
      { "tt",    "<cmd>ToggleTerm<cr>", desc = "Terminal Toggle" },
    },
    config = function()
      require("toggleterm").setup({
        size = 60,                -- 垂直分割字の横幅( 初期値 )
        open_mapping = [[<c-t>]], -- プラグイン内部での開閉マッピング
        direction = 'vertical',   -- 垂直分割( サイドパネル形式 )
        side = 'right',           -- 右側に表示
        persist_mode = true,      -- 前回のモード( 挿入/ノーマル )を保持
        persist_size = false,     -- マウスでのリサイズを有効にするため false に設定
        close_on_exit = false,    -- プロセス終了後もバッファを保持( 履歴確認用 )
        auto_scroll = true,       -- 出力にあわせて自動スクロール
        start_in_insert = true,   -- 開いた瞬間に挿入モード( Claude 操作可能にする)
      })

      -- ターミナルモード専用のキーマッピング設定
      -- 外部( keymaps.lua )からは切り離し、ここで完結させる
      local function set_terminal_keymaps()
        local opts = { buffer = 0 }

        -- マウスでのウィンドウリサイズを有効化
        -- ターミナルモードでもウィンドウ境界をマウスでドラッグしてリサイズ可能
        vim.opt_local.mouse = "a"

        -- Ctrl+w をノーマルモードの Ctrl+w と同じ挙動にする
        -- これにより Ctrl+w h や Ctrl+w w がターミナル内からでも効くようになる
        vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)

        -- ターミナルモード( t )でのウィンドウ移動
        vim.keymap.set('t', '<C-h>', [[<Cmd>windcmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>windcmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>windcmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>windcmd l<CR>]], opts)

        -- モード切り替えを楽にする
        vim.keymap.set('t', '<Esc><Esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
      end

      -- ターミナルが作成・表示されるたびにキーマップを適用する
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "term://*",
        callback = function()
          set_terminal_keymaps()
        end
      })
    end,
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

  -- 言語サポート
  {
    "evanleck/vim-svelte",
    ft = "svelte",
  }
}
