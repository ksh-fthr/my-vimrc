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

-- Fern を起動する
vim.cmd("autocmd VimEnter * ++nested Fern . -drawer -stay -keep -toggle -reveal=%")
-- dotfiles を fern で表示する
vim.cmd("let g:fern#default_hidden=1")

