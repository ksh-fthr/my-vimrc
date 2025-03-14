-- ##############################################
-- plugins
-- ##############################################
local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})


-- Install your plugins here
packer.startup(function(use)
  -- packer: プラグインマネージャ
  use({ "wbthomason/packer.nvim" })
  use({ "nvim-lua/plenary.nvim" }) -- Common utilities for Lua Library

  -- Colorschemes
  use({ "EdenEast/nightfox.nvim" }) -- Color scheme

  use({ "nvim-lualine/lualine.nvim" }) -- Statusline
  use({ "windwp/nvim-autopairs" }) -- Autopairs, integrates with both cmp and treesitter
  -- use({ "kyazdani42/nvim-web-devicons" }) -- File icons
  use({"nvim-tree/nvim-web-devicons"}) -- File icons

  use({ "akinsho/bufferline.nvim" })

  -- cmp plugins
  use({ "hrsh7th/nvim-cmp" }) -- The completion plugin
  use({ "hrsh7th/cmp-path" }) -- path completions
  use({ "hrsh7th/cmp-buffer" }) -- buffer completions
  use({ "hrsh7th/cmp-cmdline" }) -- cmdline completions
  use({ "hrsh7th/cmp-nvim-lsp" })

  -- 補完の展開を便利にする
  use({ "hrsh7th/vim-vsnip"})
  use({ "hrsh7th/vim-vsnip-integ"})

  -- autocomplete
  use({ "prabirshrestha/asyncomplete.vim" })
  use({ "prabirshrestha/asyncomplete-lsp.vim" })

  use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions
  use({ "hrsh7th/cmp-nvim-lua" })
  use({ "onsails/lspkind.nvim" })

  -- signature: https://github.com/hrsh7th/cmp-nvim-lsp-signature-help
  use({ "hrsh7th/cmp-nvim-lsp-signature-help" })
  require'cmp'.setup {
    sources = {
      { name = 'nvim_lsp_signature_help' }
    }
  }

  -- snippets
  use({ "L3MON4D3/LuaSnip" }) --snippet engine

  -- LSP
  use({ "neovim/nvim-lspconfig" }) -- enable LSP
  use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters

  -- LSP Configuration Support
  use({ 'williamboman/mason.nvim' })
  use({ 'williamboman/mason-lspconfig.nvim' })

  -- lspsaga はエラーになるので読み込まない(バージョンアップされたら治っているか試す)
  -- reference: https://github.com/nvimdev/lspsaga.nvim
  -- use({
  --     'nvimdev/lspsaga.nvim',
  --     after = 'nvim-lspconfig',
  --     config = function()
  --         require("lspsaga").setup({
  --           border_style = "single",
  --           symbol_in_winbar = {
  --             enable = true,
  --           },
  --           code_action_lightbulb = {
  --             enable = true,
  --           },
  --           show_outline = {
  --             win_width = 50,
  --             auto_preview = false,
  --           },
  --         })
  --     end
  -- })

  -- Formatter
  use({ "MunifTanjim/prettier.nvim" })

  -- Telescope: ファイル検索・テキスト検索
  use({ "nvim-telescope/telescope.nvim" })
  use({ "nvim-telescope/telescope-file-browser.nvim" })

  -- telescope-frecency.nvim をいれるとファイル読み込みの際にエラーになるのでコメントアウトしておく(バージョンアップされたら治っているか試す)
  -- https://github.com/nvim-telescope/telescope-frecency.nvim
  -- use {
  --   "nvim-telescope/telescope-frecency.nvim",
  --   config = function()
  --     require("telescope").load_extension "frecency"
  --   end,
  --   requires = { "kkharji/sqlite.lua" },
  -- }

  -- Treesitter: シンタックスハイライトやインデントを高速に処理してくれる
  -- use({ "nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" } })
  use({ "nvim-treesitter/nvim-treesitter" })

  use({ "windwp/nvim-ts-autotag" })

  -- Git
  use({ "lewis6991/gitsigns.nvim" })
  use({ "dinhhuy258/git.nvim" })

  -- Fern: ファイラ
  use({'lambdalisue/fern.vim'})

  -- Fern 上でアイコンを表示する
  -- 参考: https://qiita.com/youichiro/items/b4748b3e96106d25c5bc#%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%83%84%E3%83%AA%E3%83%BC%E3%81%AB%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E3%82%A2%E3%82%A4%E3%82%B3%E3%83%B3%E3%82%92%E8%A1%A8%E7%A4%BA%E3%81%99%E3%82%8B
  use({'lambdalisue/nerdfont.vim'})                -- アイコン表示のための拡張
  use({'lambdalisue/fern-renderer-nerdfont.vim'})  -- アイコン表示のための拡張
  use({'lambdalisue/glyph-palette.vim'})           -- アイコン表示のための拡張
  use({'lambdalisue/fern-git-status.vim'})         -- ファイルツリー上に git 差分を表示
  use({'LumaKernel/fern-mapping-reload-all.vim'})  -- リロード
  use({'yuki-yano/fern-preview.vim'})              -- ファイルプレビュー

  -- Wintabs: 開いているbufferをタブラインに表示する
  use({'zefei/vim-wintabs'})
  use({'zefei/vim-wintabs-powerline'})

  use({ "tomtom/tcomment_vim" })
  use({ "norcalli/nvim-colorizer.lua" })
  use({ "akinsho/nvim-bufferline.lua" })

  -- markdown
  -- see: https://github.com/preservim/vim-markdown
  use({'godlygeek/tabular'})
  use({'preservim/vim-markdown'})

  -- markdown preview
  -- see: https://github.com/iamcco/markdown-preview.nvim
  use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })

  -- svelte
  use({'othree/html5.vim'})
  use({'pangloss/vim-javascript'})
  use({'evanleck/vim-svelte'})

  -- gitの差分を表示する
  use({'airblade/vim-gitgutter'})

  -- ターミナルを使う
  use {
    "akinsho/toggleterm.nvim",
    tag = '*',
    config = function()
      require("toggleterm").setup()
    end
  }
  
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)


