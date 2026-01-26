-- ##############################################
-- plugins.lua (全プラグイン統合版)
-- ##############################################

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
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

  -- ########################################################
  -- LSP & Mason (以前の設定を復元)
  -- ########################################################
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
      -- ここで plugins-config/lsp-config.lua を読み込み、
      -- 以前の LSP ハンドラや設定を有効にします
      require("plugins-config/lsp-config")
    end
  },
  { "neovim/nvim-lspconfig" },

  -- 補完エンジン本体
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/vim-vsnip",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim",
    },
  },

  -- フォーマッタ
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function() require("plugins-config/formatter-config") end
  },

  -- ########################################################
  -- Telescope & Treesitter (最新修正版)
  -- ########################################################
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = { "nvim-telescope/telescope-file-browser.nvim" },
    config = function() require("plugins-config/telescope-config") end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = { "windwp/nvim-ts-autotag" },
    config = function()
      require("plugins-config/tree-sitter-config")
      require("plugins-config/auto-tag-config")
    end,
  },

  -- ########################################################
  -- Git & Filer (Fern)
  -- ########################################################
  {
    "lewis6991/gitsigns.nvim",
    config = function() require("plugins-config/git-config") end,
  },
  { "dinhhuy258/git.nvim" },

  -- ########################################################
  -- Fern (Filer) - アイコンと色を復活
  -- ########################################################
  {
    "lambdalisue/fern.vim",
    dependencies = {
      "lambdalisue/nerdfont.vim",              -- アイコンフォント
      "lambdalisue/fern-renderer-nerdfont.vim", -- FernでNerdfontを使うためのレンダラー
      "lambdalisue/glyph-palette.vim",          -- アイコンに色を付ける
      "lambdalisue/fern-git-status.vim",        -- Gitステータス表示
      "LumaKernel/fern-mapping-reload-all.vim",
      "yuki-yano/fern-preview.vim",
    },
    config = function()
      -- 起動設定
      vim.cmd("autocmd VimEnter * ++nested Fern . -drawer -stay -keep -toggle -reveal=%")

      -- 基本設定
      vim.g["fern#default_hidden"] = 1
      vim.g["fern#renderer"] = "nerdfont" -- ここでアイコンレンダラーを指定

      -- アイコンに色を付けるための設定 (glyph-palette)
      vim.cmd([[
        augroup my-glyph-palette
          autocmd! *
          autocmd FileType fern call glyph_palette#apply()
          autocmd FileType nerdtree,startify call glyph_palette#apply()
        augroup END
      ]])

      -- プレビューやリロードのマッピング設定
      vim.cmd([[
        function! s:fern_settings() abort
          nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
          nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
          nmap <silent> <buffer> <C-d> <Plug>(fern-action-preview:scroll:down:half)
          nmap <silent> <buffer> <C-u> <Plug>(fern-action-preview:scroll:up:half)
          nmap <buffer> R <Plug>(fern-action-reload:all)
        endfunction

        augroup fern-settings
          autocmd!
          autocmd FileType fern call s:fern_settings()
        augroup END
      ]])
    end,
  },

  -- ########################################################
  -- GitHub Copilot & Chat (今回の追加分)
  -- ########################################################
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },
  { "zbirenbaum/copilot-cmp", config = function() require("copilot_cmp").setup() end },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    lazy = false,
    build = "make install",
    config = function()
      require("CopilotChat").setup({
        language = "Japanese",
        window = {
          layout = 'float',
          side = 'right',
          width = 0.4,
          height = 0.8,
          relative = 'editor',
          row = 1,
          col = vim.o.columns,
        },
        show_help = false,
      })
    end,
    keys = {
      { "<leader>cc", "<cmd>CopilotChatOpen<cr>", desc = "CopilotChat - Open" },
      { "<leader>ct", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle" },
    },
  },

-- ########################################################
  -- Terminal (ToggleTerm) - 復活版
  -- ########################################################
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
})

