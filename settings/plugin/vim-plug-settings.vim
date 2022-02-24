""=========================================
" プラグイン管理
" 要: vim-plug
" └https://github.com/junegunn/vim-plug
""=========================================
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
  " vim-list
  " └https://github.com/mattn/vim-lsp-settings
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  " 言語ごとのシンタックス関連プラグイン
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  Plug 'posva/vim-vue'
  Plug 'godlygeek/tabular'
  Plug 'preservim/vim-markdown'
  " JavaScriptのSyntax関連プラグイン
  Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
  " React 関連
  Plug 'othree/yajs.vim', { 'for': ['javascript', 'javascript.jsx'] }
  Plug 'othree/es.next.syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
  Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
  " ファイラ
  Plug 'lambdalisue/fern.vim'
  Plug 'lambdalisue/nerdfont.vim'               " アイコン表示のための拡張
  Plug 'lambdalisue/fern-renderer-nerdfont.vim' " アイコン表示のための拡張
  Plug 'lambdalisue/glyph-palette.vim'          " アイコン表示のための拡張
  Plug 'lambdalisue/fern-git-status.vim'        " ファイルツリー上に git 差分を表示
  Plug 'LumaKernel/fern-mapping-reload-all.vim' " リロード
  Plug 'yuki-yano/fern-preview.vim'             " ファイルプレビュー
  " git 差分
  Plug 'airblade/vim-gitgutter'
  " ステータスバー
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  " linter補助
  Plug 'dense-analysis/ale'
  " ファイル検索
  " 下記を実行してライブラリを入れておく
  " ```
  " $ brew install bat
  " $ brew install ripgrep
  " ```
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  " URL リンクをブラウザで開く
  Plug 'tyru/open-browser.vim'
  " セッション管理
  Plug 'skanehira/vsession'
  " GitHub を便利に
  Plug 'tpope/vim-fugitive'
  " マークダウンのプレビュー表示
  " └ 要: https://github.com/MichaelMure/mdr
  "Plug 'skanehira/preview-markdown.vim'
  " https://github.com/iamcco/markdown-preview.nvim 
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
  " コメントを便利に
  Plug 'tomtom/tcomment_vim'
  " ファジーファインダ -> vim-go の GoDecls / GoDeclsDir を便利に
  Plug 'ctrlpvim/ctrlp.vim'
  " buffer を削除してもウィンドウはそのまま
  Plug 'qpkorr/vim-bufkill'
  " colorschems
  Plug 'rafi/awesome-vim-colorschemes'
call plug#end()

