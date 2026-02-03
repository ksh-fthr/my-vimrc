-- ##############################################
-- lua/plugins-config/toggle-term-config.lua
-- ToggleTerm の設定
-- ##############################################

-- 基本設定
require("toggleterm").setup({
  size = 50,                -- 垂直分割字の横幅( 初期値 )
  open_mapping = [[<c-t>]], -- プラグイン内部での開閉マッピング
  direction = 'vertical',   -- 垂直分割( サイドパネル形式 )
  side = 'right',           -- 右側に表示
  persist_mode = true,      -- 前回のモード( 挿入/ノーマル )を保持
  persist_size = false,     -- マウスでのリサイズを有効にするため false に設定
  close_on_exit = false,    -- プロセス終了後もバッファを保持( 履歴確認用 )
  auto_scroll = true,       -- 出力にあわせて自動スクロール
  start_in_insert = true,   -- 開いた瞬間に挿入モード( Claude 操作可能にする)
})

local Terminal = require("toggleterm.terminal").Terminal

-- 画面右のターミナルを開く関数
local term_right = Terminal:new({
  direction = "vertical",
  size = 80,      -- 画面右のターミナル幅
  hidden = false, -- ターミナルを非表示にしない
  id = 1,         -- ターミナルIDを指定
})

-- 画面下部のターミナルを開く設定
local term_bottom = Terminal:new({
  direction = "horizontal",
  size = 10,      -- 画面下部のターミナル高さ
  hidden = false, -- ターミナルを非表示にしない
  id = 2,         -- ターミナルIDを指定
})


-- 通常の編集ウィンドウに移動する関数
-- ターミナルや Fern などの特殊ウィンドウを避ける
local function go_to_normal_window()
  for i = 1, vim.fn.winnr('$') do
    vim.cmd(i .. 'wincmd w')
    local buftype = vim.api.nvim_buf_get_option(0, 'buftype')
    local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
    -- 通常のバッファ( terminal や fern 以外) を探す
    if buftype == 'terminal' and filetype ~= 'fern' then
      return
    end
  end
end

-- ターミナルウィンドウを探してリサイズする関数
local function resize_terminal_window(term_id, is_vertical, size)
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local buf_name = vim.api.nvim_buf_get_name(buf)
    if buf_name:match("toggleterm#" .. term_id) then
      if is_vertical then
        vim.api.nvim_win_set_width(win, size)
      else
        vim.api.nvim_win_set_height(win, size)
      end
      return
    end
  end
end

-- キーマッピング設定
-- 画面右のターミナルを開閉: Ctrl+\
vim.keymap.set('n', 'C-t', function()
  go_to_normal_window()
  term_right:toggle()
  if term_right:is_open() then
    vim.cmd("wincmd L")                    -- 右のウィンドウに移動
    vim.defer_fn(function()
      resize_terminal_window(1, true, 100) -- 画面右ターミナルの幅を100に設定
    end, 50)
  end
end, { noremap = true, silent = true, desc = "Toggle Right Terminal" })

-- 画面下部のターミナルを開閉: Ctrl+b
vim.keymap.set('n', '<C-b>', function()
  go_to_normal_window()
  term_bottom:toggle()
  if term_bottom:is_open() then
    vim.cmd("wincmd J")                    -- 下のウィンドウに移動
    vim.defer_fn(function()
      resize_terminal_window(2, false, 20) -- 画面右ターミナルの幅を100に設定
    end, 50)
  end
end, { noremap = true, silent = true, desc = "Toggle Bottom Terminal" })

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
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)

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
