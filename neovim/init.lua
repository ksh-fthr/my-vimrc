require("base")
require("keymaps")

-- plugin 管理
require("plugins")

-- 以降,  plugin 設定
require("plugins-config/status-line-config")
require("plugins-config/git-config")
require("plugins-config/lsp-config")
require("plugins-config/lspsaga-config")
require("plugins-config/formatter-config")
require("plugins-config/tree-sitter-config")
require("plugins-config/auto-tag-config")
require("plugins-config/tab-config")
require("plugins-config/telescope-config")
require("plugins-config/markdown-config")

-- Fern を起動する
vim.cmd("autocmd VimEnter * ++nested Fern . -drawer -stay -keep -toggle -reveal=%")
-- dotfiles を fern で表示する
vim.cmd("let g:fern#default_hidden=1")

-- Fern 上でアイコンを表示するために Nerdfont を使う
-- 事前に https://github.com/yumitsu/font-menlo-extra/blob/master/Menlo-Regular-Normal.ttf からフォントをインストールしておく
-- 参考: https://qiita.com/youichiro/items/b4748b3e96106d25c5bc#%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%83%84%E3%83%AA%E3%83%BC%E3%81%AB%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E3%82%A2%E3%82%A4%E3%82%B3%E3%83%B3%E3%82%92%E8%A1%A8%E7%A4%BA%E3%81%99%E3%82%8B
vim.cmd('let g:fern#renderer="nerdfont"')

-- アイコンに色をつける
-- 参考: https://qiita.com/youichiro/items/b4748b3e96106d25c5bc#%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%83%84%E3%83%AA%E3%83%BC%E3%81%AE%E3%82%A2%E3%82%A4%E3%82%B3%E3%83%B3%E3%81%AB%E8%89%B2%E3%82%92%E3%81%A4%E3%81%91%E3%82%8B
vim.cmd([[
  augroup my-glyph-palette
    autocmd! *
    autocmd FileType fern call glyph_palette#apply()
    autocmd FileType nerdtree,startify call glyph_palette#apply()
  augroup END
]])


