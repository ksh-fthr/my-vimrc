-- ##############################################
-- Base
-- ##############################################
vim.cmd("autocmd!")

vim.scriptencoding = "utf-8"

vim.wo.number = true


-- ##############################################
-- autocmd
-- ##############################################
local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- Remove whitespace on save
autocmd("BufWritePre", {
  pattern = "*",
  command = ":%s/\\s\\+$//e",
})

-- Don't auto commenting new lines
autocmd("BufEnter", {
  pattern = "*",
  command = "set fo-=c fo-=r fo-=o",
})

-- Restore cursor location when file is opened
autocmd({ "BufReadPost" }, {
  pattern = { "*" },
  callback = function()
    vim.api.nvim_exec('silent! normal! g`"zv', false)
  end,
})


-- ##############################################
-- options
-- ##############################################
local options = {
  encoding = "utf-8",
  fileencoding = "utf-8",
  title = true,
  backup = false,
  clipboard = "unnamedplus",
  cmdheight = 2,
  completeopt = { "menuone", "noselect" },
  conceallevel = 0,
  hlsearch = true,
  ignorecase = true,
  mouse = "a",
  pumheight = 10,
  showmode = false,
  showtabline = 2,
  smartcase = true,
  smartindent = true,
  swapfile = false,
  termguicolors = true,
  timeoutlen = 300,
  undofile = true,
  updatetime = 300,
  writebackup = false,
  shell = "fish",
  backupskip = { "/tmp/*", "/private/tmp/*" },
  expandtab = true,
  shiftwidth = 2,
  tabstop = 2,
  cursorline = true,
  number = true,
  relativenumber = false,
  numberwidth = 4,
  signcolumn = "yes",
  wrap = false,
  winblend = 0,
  wildoptions = "pum",
  pumblend = 5,
  background = "dark",
  scrolloff = 8,
  sidescrolloff = 8,
  guifont = "monospace:h17",
  splitbelow = false, -- オンのとき、ウィンドウを横分割すると新しいウィンドウはカレントウィンドウの下に開かれる
  splitright = false, -- オンのとき、ウィンドウを縦分割すると新しいウィンドウはカレントウィンドウの右に開かれる
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
vim.cmd([[set formatoptions-=cro]]) -- TODO: this doesn't seem to work

-- ##############################################
-- keymap
-- ##############################################
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

--local keymap = vim.keymap
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   visual_block_mode = 'x',
--   term_mode = 't',
--   command_mode = 'c',

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- New tab
keymap("n", "te", ":tabedit", opts)
-- 新しいタブを一番右に作る
keymap("n", "gn", ":tabnew<Return>", opts)
-- move tab
keymap("n", "gh", "gT", opts)
keymap("n", "gl", "gt", opts)

-- Split window
keymap("n", "ss", ":split<Return><C-w>w", opts)
keymap("n", "sv", ":vsplit<Return><C-w>w", opts)

-- Select all
keymap("n", "<C-a>", "gg<S-v>G", opts)

-- Do not yank with x
keymap("n", "x", '"_x', opts)

-- Delete a word backwards
keymap("n", "dw", 'vb"_d', opts)

-- 行の端に行く
keymap("n", "<Space>h", "^", opts)
keymap("n", "<Space>l", "$", opts)

-- ;でコマンド入力( ;と:を入れ替)
keymap("n", ";", ":", opts)

-- 行末までのヤンクにする
keymap("n", "Y", "y$", opts)

-- <Space>q で強制終了
keymap("n", "<Space>q", ":<C-u>q!<Return>", opts)

-- ESC*2 でハイライトやめる
keymap("n", "<Esc><Esc>", ":<C-u>set nohlsearch<Return>", opts)

-- Telescope
keymap("n",  "ff",  ":Telescope find_files<Return>",  opts)
keymap("n",  "fb",  ":Telescope buffers<Return>",  opts)
keymap("n",  "fg",  ":Telescope live_grep<Return>",  opts)


-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)

-- コンマの後に自動的にスペースを挿入
keymap("i", ",", ",<Space>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- ビジュアルモード時vで行末まで選択
keymap("v", "v", "$h", opts)

-- 0番レジスタを使いやすくした
keymap("v", "<C-p>", '"0p', opts)


-- ##############################################
-- coloerscheme
-- ##############################################
vim.cmd [[
try
  colorscheme nightfox
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]


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

-- 1. LSP Sever management
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
--
-- 2. build-in LSP function
-- keyboard shortcut
vim.keymap.set('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
-- LSP handlers
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)
-- Reference highlight
vim.cmd [[
set updatetime=500
highlight LspReferenceText  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
highlight LspReferenceRead  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
highlight LspReferenceWrite cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
augroup lsp_document_highlight
  autocmd!
  autocmd CursorHold,CursorHoldI * lua vim.lsp.buf.document_highlight()
  autocmd CursorMoved,CursorMovedI * lua vim.lsp.buf.clear_references()
augroup END
]]

-- 3. completion (hrsh7th/nvim-cmp)
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


-- Install your plugins here
return packer.startup(function(use)
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
  use({ "williamboman/nvim-lsp-installer" }) -- simple to use language server installer
  use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters
  use({ "glepnir/lspsaga.nvim" }) -- LSP UIs
  use({ 'williamboman/mason.nvim' })
  use({ 'williamboman/mason-lspconfig.nvim' })

  -- Formatter
  use({ "MunifTanjim/prettier.nvim" })

  -- Telescope
  use({ "nvim-telescope/telescope.nvim" })

  -- Treesitter
  use({ "nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" } })
  use({ "nvim-telescope/telescope-file-browser.nvim" })

  use({ "windwp/nvim-ts-autotag" })

  use({ "tomtom/tcomment_vim" })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

