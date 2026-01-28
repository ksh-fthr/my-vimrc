-- ##############################################
-- lua/plugins.lua
-- ##############################################
return {
  -- ユーティリティ
  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-web-devicons" },

  -- 見た目・UI
  {
    "EdenEast/nightfox.nvim",
    config = function() vim.cmd("colorscheme nightfox") end,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function() require("plugins-config/status-line-config") end,
  },
  {
    "akinsho/bufferline.nvim",
    config = function() require("plugins-config/tab-config") end,
  },

  -- 編集補助
  {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup({}) end,
  },
  { "tomtom/tcomment_vim" },
  { "norcalli/nvim-colorizer.lua" },

  -- LSP & Mason
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function() require("mason").setup() end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "mason.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/nvim-cmp",
      "onsails/lspkind.nvim",
    },
    config = function()
      -- plugins-config/lsp-config.lua を読み込む
      require("plugins-config/lsp-config")
    end
  },
  { "neovim/nvim-lspconfig" },

  -- 補完エンジン
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" }, -- 入力モード時に確実にロード
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
      {
        "zbirenbaum/copilot-cmp",
        config = function()
          require("copilot_cmp").setup()
        end,
      },
    },
    config = function()
      -- 設定ファイル (lsp-config.lua等) を読み込む
      require("plugins-config/lsp-config")
    end,
  },

  -- フォーマッタ
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function() require("plugins-config/formatter-config") end
  },

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    config = function() require("plugins-config/git-config") end,
  },
  { "dinhhuy258/git.nvim" },

  -- Fern
  {
    "lambdalisue/fern.vim",
    dependencies = {
      "lambdalisue/nerdfont.vim",
      "lambdalisue/fern-renderer-nerdfont.vim",
      "lambdalisue/glyph-palette.vim",
      "lambdalisue/fern-git-status.vim",
    },
    config = function()
      vim.cmd("autocmd VimEnter * ++nested Fern . -drawer -stay -keep -toggle -reveal=%")
      vim.cmd([[
        augroup my-glyph-palette
          autocmd! *
          autocmd FileType fern call glyph_palette#apply()
        augroup END
      ]])
    end,
  },

  -- 補完エンジン (nvim-cmp) と Copilot 連携
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" }, -- 入力モード時に確実にロード
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
      -- ここが重要：copilot-cmp を依存関係に追加し、本体を呼ぶ
      {
        "zbirenbaum/copilot-cmp",
        config = function()
          require("copilot_cmp").setup()
        end,
      },
    },
    config = function()
      -- 設定ファイル (lsp-config.lua等) を読み込む
      require("plugins-config/lsp-config")
    end,
  },

  -- Copilot Chat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    lazy = false,
    build = "make install",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
      { "sindrets/diffview.nvim" }, -- Diff連携用
    },
    opts = {
      -- AIの性格を強制的に矯正する設定
      system_prompt = "あなたは有能なエンジニアです。回答は必ず日本語で行い、コードの修正案は必ずMarkdownのコードブロック形式で記述してください。返答の冒頭に挨拶や承諾の言葉は不要です。すぐにコードを出力してください。今のバッファを直接書き換えることはできないので、必ずこのチャット欄に修正後の全コードを提示してください。",
      language = "Japanese",
      window = {
        layout = 'float',
        side = 'right',
        width = 0.4,
        height = 0.9,
        relative = 'editor',
        row = 1,
        col = vim.o.columns,
      },
      show_help = false,
      -- キーマップ設定
      mappings = {
        diff = {
          normal = '<C-d>', -- チャット内で Ctrl+d を押すと DiffView を起動
        },
      },
    },
    keys = {
      { "<leader>cc", "<cmd>CopilotChatOpen<cr>", desc = "CopilotChat - Open" },
      { "<leader>ct", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle" },
      { "<leader>cr", "<cmd>CopilotChatReset<cr>", desc = "CopilotChat - Reset" },
      -- リファクタリングなどのアクションメニューを Telescope で開く
      {
        "<leader>ca",
        function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
        end,
        desc = "CopilotChat - Prompt actions",
      },
    },
  },

  -- ToggleTerm
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        -- ターミナルを開くキー (Ctrl + t)
        open_mapping = [[<C-t>]],
        direction = 'float', -- 浮遊ウィンドウで開く（'horizontal', 'vertical' も可）
        -- shell をシステム標準のものに強制する（エラー回避）
        shell = vim.o.shell,
        float_opts = {
          border = 'curved',
          winblend = 3,
        },
      })

      -- ターミナル内での操作を快適にするためのキーマップ設定
      function _G.set_terminal_keymaps()
        local opts = {buffer = 0}
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-w>h]], opts)
        vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-w>j]], opts)
        vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-w>k]], opts)
        vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-w>l]], opts)
      end

      -- ターミナルを開いた時だけ上記キーマップを有効化
      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    end,
  },
  
  -- Telescope (エラー回避のため config を修正)
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8", -- 修正版のタグに変更
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          -- プレビューアでのエラー回避用設定
          preview = {
            treesitter = false, -- これを false にすると ft_to_lang エラーが消えます
          },
        },
      })
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = { "windwp/nvim-ts-autotag" },
    config = function()
      require("plugins-config/tree-sitter-config")
      require("plugins-config/auto-tag-config")
    end,
  },

  -- DiffView
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
  },
}
