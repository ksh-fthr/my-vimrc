-- ##############################################
-- keymap
-- ##############################################
local opts = {
    noremap = true,
    silent = true
}
local term_opts = {
    silent = true
}

local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
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

-- ---------------------------------
-- Normal Mode
-- ---------------------------------
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
keymap("n", "ff", ":Telescope find_files<Return>", opts)
keymap("n", "fb", ":Telescope buffers<Return>", opts)
keymap("n", "fg", ":Telescope live_grep<Return>", opts)

-- Fern 起動/停止 をトグルで
keymap("n", "fr", ":Fern . -drawer -stay -keep -toggle -reveal=%<Return>", opts)

-- wintab
keymap('n', '<C-n>', '<cmd>bnext<cr>', opts)
keymap('n', '<C-p>', '<cmd>bprevious<cr>', opts)
-- バッファを閉じる
keymap('n', '<C-q>', '<cmd>b#<cr><cmd>bd#<cr>', opts)
keymap('n', '<C-d>', '<cmd>b#<cr><cmd>bd#<cr>', opts)
-- keymap("n",  "<C-d>",  ":bd<Return>",  opts)

-- ---------------------------------
-- Insert Mode
-- ---------------------------------
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)

-- コンマの後に自動的にスペースを挿入
keymap("i", ",", ",<Space>", opts)

-- ---------------------------------
-- Visual Mode
-- ---------------------------------
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- ビジュアルモード時vで行末まで選択
keymap("v", "v", "$h", opts)

-- 0番レジスタを使いやすくした
keymap("v", "<C-p>", '"0p', opts)

-- ターミナルを使う
-- akinsho/toggleterm.nvim プラグインを使う
require("toggleterm").setup {
    -- open_mapping = [[<c-\>]], -- Ctrl + \ でターミナルをトグル
    -- size = 20, -- ターミナルウィンドウの高さ
    -- direction = 'float' -- ターミナルの表示方向（horizontal, vertical, float）
    size = 20,
    open_mapping = [[<c-\>]],
    direction = 'float',  -- ターミナルの方向 (horizontal, vertical, float)
    shading_factor = 2,
    shade_terminals = true,
    start_in_insert = true,
}

-- ターミナルをトグルするためのキーバインディング
keymap('n', 'tt', '<cmd>ToggleTerm<CR>', {
    noremap = true,
    silent = true
})
