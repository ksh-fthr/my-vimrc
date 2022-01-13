""=========================================
" スクリプトファイル読み込み
""=========================================
source <sfile>:h/.keymapping.vim

""=========================================
" 主だった設定
""=========================================
set encoding=utf-8
source $VIMRUNTIME/delmenu.vim
set langmenu=ja_jp.utf-8
source $VIMRUNTIME/menu.vim
set fileencodings=utf-8
set fileformats=unix
set nu
set columns=170
set lines=45
set noundofile
set nobackup
set noundofile
set ts=4 sw=4 tw=0 expandtab
set smartindent
set nowrap
set cmdheight=2
set cursorline
set ruler
set showcmd
set wildmenu
set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
set showtabline=2
set guifontwide=MyricaM\ 16  " 全角文字 要: (MyricaM https://myrica.estable.jp/myricamhistry/)
set guifont=MyricaM\ 16   " 半角文字 要: (MyricaM https://myrica.estable.jp/myricamhistry/)
set clipboard=unnamedplus " ヤンクした内容をクリップボードと共有

colorscheme zabanya


" 折りたたみ
set foldmethod=syntax
let perl_fold=1
set foldlevel=100

" 改行時のコメントを無効にする
autocmd FileType * setlocal formatoptions-=ro

""=========================================
" ファイルタイプごとにインデントを設定
""=========================================
if has("autocmd")
  "ファイルタイプの検索を有効にする
  filetype plugin on
  "ファイルタイプに合わせたインデントを利用
  filetype indent on
  "sw=shiftwidth, sts=softtabstop, ts=tabstop, et=expandtabの略
  autocmd FileType html        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType ts          setlocal sw=2 sts=2 ts=2 et
  autocmd FileType vue         setlocal sw=2 sts=2 ts=2 et
  autocmd FileType javascript  setlocal sw=2 sts=2 ts=2 et
  autocmd FileType js          setlocal sw=2 sts=2 ts=2 et
  autocmd FileType json        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType zsh         setlocal sw=2 sts=2 ts=2 et
  autocmd FileType python      setlocal sw=2 sts=2 ts=2 et
  autocmd FileType css         setlocal sw=2 sts=2 ts=2 et
  autocmd FileType scss        setlocal sw=2 sts=2 ts=2 et
endif

""=========================================
" netrwの設定
""=========================================
" netrwは常にtree view
let g:netrw_liststyle = 3
" CVSと.で始まるファイルは表示しない
let g:netrw_list_hide = 'CVS,\(^\|\s\s\)\zs\.\S\+'
" 'v'でファイルを開くときは右側に開く。(デフォルトが左側なので入れ替え)
let g:netrw_altv = 1
" 'o'でファイルを開くときは下側に開く。(デフォルトが上側なので入れ替え)
let g:netrw_alto = 1

""=========================================
" git 関連の設定
" 要: vim-gitgutter
" └https://github.com/airblade/vim-gitgutter
""=========================================
" 記号の色を変更する
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=blue
highlight GitGutterDelete ctermfg=red


""=========================================
" ファイルフォーマッタ
" 要: ALE (Asynchronous Lint Engine) 
" └https://github.com/dense-analysis/ale
""=========================================
" Set this variable to 1 to fix files when you save them.
let b:ale_linter_aliases = ['javascript', 'vue']
let b:ale_linters = ['eslint', 'vls']
let b:ale_fixers = {'javascript': ['prettier', 'eslint'],'vue': ['eslint', 'vls']}
let b:ale_linters = {'javascript': ['prettier', 'eslint'],'vue': ['eslint', 'vls']}
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" Write this in your vimrc file
"let g:ale_lint_on_text_changed = 'never'
"let g:ale_lint_on_insert_leave = 0
" if you don't want linters to run on opening a file
"let g:ale_lint_on_enter = 0
let g:ale_linters_explicit = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_fix_on_save = 1

""=========================================
" 括弧の自動補完
""=========================================
" () の自動補完
inoremap ( ()<ESC>i
inoremap <expr> ) ClosePair(')')

" {} の自動補完
inoremap { {}<ESC>i
inoremap <expr> } ClosePair('}')

" [] の自動補完
inoremap [ []<ESC>i
inoremap <expr> ] ClosePair(']')

" <> の自動補完
inoremap < <><ESC>i
inoremap <expr> > ClosePair('>')

" pair close checker.
" from othree vimrc ( http://github.com/othree/rc/blob/master/osx/.vimrc )

" ClosePairは起動時のみ実行するようにする
if has('vim_starting')
    function ClosePair(char)
        if getline('.')[col('.') - 1] == a:char
            return "\<Right>"
        else
            return a:char
        endif
    endf
endif


""=========================================
" ファイル保存
""=========================================
"ファイル保存時にディレクトリが無ければ自動作成する
augroup __vimrc-auto-mkdir__  " {{{
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'))
  function! s:auto_mkdir(dir)  " {{{
    if !isdirectory(a:dir)
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction  " }}}
augroup END  " }}}

""=========================================
" for Vue.js
""=========================================
" syntax
autocmd FileType vue syntax sync fromstart

" Vue のシンタックスハイライト
" 要: posva/vim-vue
" └https://github.com/posva/vim-vue
let g:vue_pre_processors = 'detect_on_enter'

" comment
let g:ft = ''
function! NERDCommenter_before()
  if &ft == 'vue'
    let g:ft = 'vue'
    let stack = synstack(line('.'), col('.'))
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
        exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
      endif
    endif
  endif
endfunction
function! NERDCommenter_after()
  if g:ft == 'vue'
    setf vue
    let g:ft = ''
  endif
endfunction

" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
  set nocompatible               " Be iMproved
endif

""=========================================
" for javascript-libraries-syntax
" └https://github.com/othree/javascript-libraries-syntax.vim
""=========================================
let g:used_javascript_libs = 'jquery,underscore,react,flux,jasmine,d3'
autocmd BufReadPre *.js let b:javascript_lib_use_jquery = 1
autocmd BufReadPre *.js let b:javascript_lib_use_underscore = 1
autocmd BufReadPre *.js let b:javascript_lib_use_react = 1
autocmd BufReadPre *.js let b:javascript_lib_use_flux = 1
autocmd BufReadPre *.js let b:javascript_lib_use_jasmine = 1
autocmd BufReadPre *.js let b:javascript_lib_use_d3 = 1

""=========================================
" for vim-javascript
" └https://github.com/pangloss/vim-javascript
""=========================================
let g:javascript_plugin_jsdoc = 1
"let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1
augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END

""=========================================
" for vim-plug
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
  " ファイルツリー上に git 差分を表示
  Plug 'lambdalisue/fern-git-status.vim'
  " リロード
  Plug 'LumaKernel/fern-mapping-reload-all.vim'
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
call plug#end()


