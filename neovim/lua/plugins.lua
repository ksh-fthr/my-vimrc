-- ##############################################
-- plugins (Lazy.nvim)
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
  -- Common utilities
  { "nvim-lua/plenary.nvim" },

  -- Colorschemes
  {
    "EdenEast/nightfox.nvim",
    config = function()
      vim.cmd("colorscheme nightfox")
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugins-config/status-line-config")
    end,
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  -- Icons
  { "nvim-tree/nvim-web-devicons" },

  -- Bufferline
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugins-config/tab-config")
    end,
  },

  -- ########################################################
  -- GitHub Copilot & Completion
  -- ########################################################
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  -- cmp plugins
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/vim-vsnip",
      "hrsh7th/vim-vsnip-integ",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "L3MON4D3/LuaSnip",
    },
  },

  -- ########################################################
  -- LSP & Mason
  -- ########################################################
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end
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
      require("plugins-config/lsp-config")
    end
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
  },

  -- Formatter / Linter
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("plugins-config/formatter-config")
    end
  },
  { "MunifTanjim/prettier.nvim" },

  -- ########################################################
  -- Telescope
  -- ########################################################
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
      require("plugins-config/telescope-config")
    end,
  },

  -- ########################################################
  -- Treesitter
  -- ########################################################
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag",
    },
    config = function()
      require("plugins-config/tree-sitter-config")
      require("plugins-config/auto-tag-config")
    end,
  },

  -- ########################################################
  -- Git
  -- ########################################################
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugins-config/git-config")
    end,
  },
  { "dinhhuy258/git.nvim" },
  { "airblade/vim-gitgutter" },

  -- ########################################################
  -- Fern (Filer)
  -- ########################################################
  {
    "lambdalisue/fern.vim",
    dependencies = {
      "lambdalisue/nerdfont.vim",
      "lambdalisue/fern-renderer-nerdfont.vim",
      "lambdalisue/glyph-palette.vim",
      "lambdalisue/fern-git-status.vim",
      "LumaKernel/fern-mapping-reload-all.vim",
      "yuki-yano/fern-preview.vim",
    },
    config = function()
      vim.cmd("autocmd VimEnter * ++nested Fern . -drawer -stay -keep -toggle -reveal=%")
      vim.g["fern#default_hidden"] = 1
      vim.g["fern#renderer"] = "nerdfont"

      vim.cmd([[
        augroup my-glyph-palette
          autocmd! *
          autocmd FileType fern call glyph_palette#apply()
          autocmd FileType nerdtree,startify call glyph_palette#apply()
        augroup END
      ]])

      vim.cmd([[
        function s:init_fern_mapping_reload_all()
            nmap <buffer> R <Plug>(fern-action-reload:all)
        endfunction
        augroup my-fern-mapping-reload-all
            autocmd! *
            autocmd FileType fern call s:init_fern_mapping_reload_all()
        augroup END
      ]])

      vim.cmd([[
        function! s:fern_settings() abort
          nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
          nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
          nmap <silent> <buffer> <C-d> <Plug>(fern-action-preview:scroll:down:half)
          nmap <silent> <buffer> <C-u> <Plug>(fern-action-preview:scroll:up:half)
        endfunction

        augroup fern-settings
          autocmd!
          autocmd FileType fern call s:fern_settings()
        augroup END
      ]])
    end,
  },

  -- ########################################################
  -- Other Utils
  -- ########################################################
  { "zefei/vim-wintabs" },
  { "zefei/vim-wintabs-powerline" },
  { "tomtom/tcomment_vim" },
  { "norcalli/nvim-colorizer.lua" },

  -- Markdown
  { "godlygeek/tabular" },
  {
    "preservim/vim-markdown",
    config = function()
      require("plugins-config/markdown-config")
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },

  -- HTML / JS / Svelte
  { "othree/html5.vim" },
  { "pangloss/vim-javascript" },
  { "evanleck/vim-svelte" },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup()
    end,
  },
})
