-- ##############################################
-- lua/plugins-config/lspsaga-keymap-config.lua
-- ##############################################
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Lspsaga 本体がロードされているか確認
local status, saga = pcall(require, "lspsaga")
if not status then return end

saga.setup({}) -- 初期化

-- 検索/定義
keymap("n", "gh", "<cmd>Lspsaga finder<CR>", opts)               -- 参照個所の検索
keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts)      -- 直接ジャンプ
keymap("n", "gp", "<cmd>Lspsaga peek_definition<CR>", opts)      -- フローティングウィンドウで確認
keymap("n", "gt", "<cmd>Lspsaga goto_type_definition<CR>", opts) -- 型定義にジャンプ

-- アクション/名前変更
keymap({ "n", "v" }, "ga", "<cmd>Lspsaga code_action<CR>", opts)
keymap("n", "gr", "<cmd>Lspsaga rename<CR>", opts) -- リネーム

-- 診断(Diagnostics)
keymap("n", "sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
keymap("n", "sb", "<cmd>Lspsaga show_buf_diagnostics<CR>", opts)
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)

-- その他
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
keymap("n", "to", "<cmd>Lspsaga outline<CR>", opts)
keymap("n", "ci", "<cmd>Lspsaga incoming_calls<CR>", opts)
keymap("n", "co", "<cmd>Lspsaga outgoing_calls<CR>", opts)
