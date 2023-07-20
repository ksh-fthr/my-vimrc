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
  -- My plugins here

  use({ "wbthomason/packer.nvim" })
  use({ "nvim-lua/plenary.nvim" }) -- Common utilities

  -- Colorschemes
  use({ "EdenEast/nightfox.nvim" }) -- Color scheme

  use({ "nvim-lualine/lualine.nvim" }) -- Statusline
  use({ "windwp/nvim-autopairs" }) -- Autopairs, integrates with both cmp and treesitter
  use({ "kyazdani42/nvim-web-devicons" }) -- File icons
  use({ "akinsho/bufferline.nvim" })

  -- cmp plugins
  use({ "hrsh7th/nvim-cmp" }) -- The completion plugin
  use({ "hrsh7th/cmp-path" }) -- path completions
  --use({ "hrsh7th/cmp-buffer" }) -- buffer completions
  --use({ "hrsh7th/cmp-cmdline" }) -- cmdline completions
  use({ "hrsh7th/cmp-nvim-lsp"})
  use({ "hrsh7th/vim-vsnip"})
  use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions
  use({ "hrsh7th/cmp-nvim-lua" })
  use({ "onsails/lspkind-nvim" })

  -- snippets
  use({ "L3MON4D3/LuaSnip" }) --snippet engine

  -- LSP
  use({ "neovim/nvim-lspconfig" }) -- enable LSP
  use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters
  use({ 'williamboman/mason.nvim' })
  use({ 'williamboman/mason-lspconfig.nvim' })

  -- reference: https://github.com/glepnir/lspsaga.nvim#packer
  use({
      "glepnir/lspsaga.nvim",
      branch = "main",
      config = function()
          require("lspsaga").setup({})
      end,
      requires = {
          {"nvim-tree/nvim-web-devicons"},
          --Please make sure you install markdown and markdown_inline parser
          {"nvim-treesitter/nvim-treesitter"}
      }
  })

  -- Formatter
  use({ "MunifTanjim/prettier.nvim" })

  -- Telescope
  use({ "nvim-telescope/telescope.nvim" })

  -- Treesitter
  use({ "nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" } })
  use({ "nvim-telescope/telescope-file-browser.nvim" })

  use({ "windwp/nvim-ts-autotag" })

  -- Git
  use({ "lewis6991/gitsigns.nvim" })
  use({ "dinhhuy258/git.nvim" })

  -- Fern
  use({'lambdalisue/fern.vim'})
  -- use({'lambdalisue/nerdfont.vim'})                -- アイコン表示のための拡張
  -- use({'lambdalisue/fern-renderer-nerdfont.vim'})  -- アイコン表示のための拡張
  -- use({'lambdalisue/glyph-palette.vim'})           -- アイコン表示のための拡張
  -- use({'lambdalisue/fern-git-status.vim'})         -- ファイルツリー上に git 差分を表示
  -- use({'LumaKernel/fern-mapping-reload-all.vim'})  -- リロード
  -- use({'yuki-yano/fern-preview.vim'})              -- ファイルプレビュー

  -- Wintabs
  use({'zefei/vim-wintabs'})
  use({'zefei/vim-wintabs-powerline'})

  use({ "tomtom/tcomment_vim" })
  use({ "norcalli/nvim-colorizer.lua" })
  use({ "akinsho/nvim-bufferline.lua" })

  -- markdown
  -- see: https://github.com/preservim/vim-markdown
  use({'godlygeek/tabular'})
  use({'preservim/vim-markdown'})

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)


