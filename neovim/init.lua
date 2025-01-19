require("base")
require("keymaps")

-- plugin 管理
require("plugins")

-- 以降,  plugin 設定
require("plugins-config/status-line-config")
require("plugins-config/git-config")
require("plugins-config/lsp-config")
-- lspsaga はエラーになるのでキーマップも読み込まない(バージョンアップされたら治っているか試す)
-- require("plugins-config/lspsaga-keymap-config")
require("plugins-config/formatter-config")
require("plugins-config/tree-sitter-config")
require("plugins-config/auto-tag-config")
require("plugins-config/tab-config")
require("plugins-config/telescope-config")
require("plugins-config/markdown-config")

-- *********************************************************
-- Fern 関連はここで設定する
-- *********************************************************
-- Fern を起動する
vim.cmd("autocmd VimEnter * ++nested Fern . -drawer -stay -keep -toggle -reveal=%")
-- dotfiles を fern で表示する
vim.cmd("let g:fern#default_hidden=1")

-- Fern 上でアイコンを表示するために Nerdfont を使う
-- 事前に https://github.com/yumitsu/font-menlo-extra/blob/master/Menlo-Regular-Normal.ttf からフォントをインストールしておく
-- 参考: https://qiita.com/youichiro/items/b4748b3e96106d25c5bc#%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%83%84%E3%83%AA%E3%83%BC%E3%81%AB%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E3%82%A2%E3%82%A4%E3%82%B3%E3%83%B3%E3%82%92%E8%A1%A8%E7%A4%BA%E3%81%99%E3%82%8B
vim.cmd('let g:fern#renderer="nerdfont"')

-- Fern 上のアイコンに色をつける
-- 参考: https://qiita.com/youichiro/items/b4748b3e96106d25c5bc#%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%83%84%E3%83%AA%E3%83%BC%E3%81%AE%E3%82%A2%E3%82%A4%E3%82%B3%E3%83%B3%E3%81%AB%E8%89%B2%E3%82%92%E3%81%A4%E3%81%91%E3%82%8B
vim.cmd([[
  augroup my-glyph-palette
    autocmd! *
    autocmd FileType fern call glyph_palette#apply()
    autocmd FileType nerdtree,startify call glyph_palette#apply()
  augroup END
]])

-- Fern のツリー更新プラグインの設定
-- https://github.com/LumaKernel/fern-mapping-reload-all.vim
vim.cmd([[
  function s:init_fern_mapping_reload_all()
      nmap <buffer> R <Plug>(fern-action-reload:all)
  endfunction
  augroup my-fern-mapping-reload-all
      autocmd! *
      autocmd FileType fern call s:init_fern_mapping_reload_all()
  augroup END
]])

-- Fern 上でファイル選択時にプレビュー表示する
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

