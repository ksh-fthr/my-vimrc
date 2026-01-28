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
  { "akinsho/bufferline.nvim", config = function() require("plugins-config/tab-config") end },

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
      "onsails/lspkind.nvim",
      { "zbirenbaum/copilot-cmp", config = function() require("copilot_cmp").setup() end },
    },
  },

  -- 編集補助
  { "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup({}) end },
  { "tomtom/tcomment_vim" },
  { "norcalli/nvim-colorizer.lua", config = function() require("colorizer").setup() end },
  { "jose-elias-alvarez/null-ls.nvim", config = function() require("plugins-config/formatter-config") end },

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
    },
    config = function()
      vim.cmd("autocmd VimEnter * ++nested Fern . -drawer -stay -keep -toggle -reveal=%")
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "fern",
        callback = function() vim.fn["glyph_palette#apply"]() end,
      })
    end,
  },

  -- AI & Terminal (プロンプト・キーマップを完全保持)
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    build = "make install",
    dependencies = { "zbirenbaum/copilot.lua", "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
    opts = {
      system_prompt = "あなたは有能なエンジニアです。回答は必ず日本語で行い、コードの修正案は必ずMarkdownのコードブロック形式で記述してください。返答の冒頭に挨拶や承諾の言葉は不要です。すぐにコードを出力してください。今のバッファを直接書き換えることはできないので、必ずこのチャット欄に修正後の全コードを提示してください。",
      language = "Japanese",
      window = { layout = 'float', side = 'right', width = 0.4, height = 0.9, relative = 'editor', row = 1, col = vim.o.columns },
      show_help = false,
      mappings = { diff = { normal = '<C-d>' } },
    },
    keys = {
      { "<leader>cc", "<cmd>CopilotChatOpen<cr>", desc = "Chat Open" },
      { "<leader>ct", "<cmd>CopilotChatToggle<cr>", desc = "Chat Toggle" },
      { "<leader>cr", "<cmd>CopilotChatReset<cr>", desc = "Chat Reset" },
      { "<leader>ca", function()
          local actions = require("CopilotChat.actions")
          require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
        end, desc = "Chat Actions" },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<C-t>]],
        direction = 'float',
        shell = "/bin/bash",
        float_opts = { border = 'curved', winblend = 3 },
      })
      function _G.set_terminal_keymaps()
        local opts = {buffer = 0}
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-w>h]], opts)
        vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-w>j]], opts)
        vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-w>k]], opts)
        vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-w>l]], opts)
      end
      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    end,
  },

  -- Search & Syntax
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    config = function()
      require("telescope").setup({ defaults = { preview = { treesitter = false } } })
    end,
  },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "sindrets/diffview.nvim" },
}
