set encoding=utf-8
source $VIMRUNTIME/delmenu.vim
set langmenu=ja_jp.utf-8
source $VIMRUNTIME/menu.vim
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileformats=unix,dos,mac
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
" open-browser.vim の設定
" 要: open-browser.vim
" └https://github.com/tyru/open-browser.vim
""=========================================
" URL にカーソルがある状態で `gx` -> ブラウザで URL が開く
" 文字列にカーソルがある状態で `gx` -> ブラウザ上で google 検索
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
nnoremap <Leader>o :<C-u>execute "OpenBrowser" "file:///" . expand('%:p:gs?\\?/?')<CR>

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
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  Plug 'posva/vim-vue'
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
call plug#end()

""=========================================
" キーマッピング
""=========================================
" 要: vim-gitgutter
" └https://github.com/airblade/vim-gitgutter
" ghでdiffをハイライトする
nnoremap gh :GitGutterLineHighlightsToggle<CR>
" gpでカーソル行のdiffを表示する
nnoremap gp :GitGutterPreviewHunk<CR>

" ファイル検索
" 要: fzf
" └https://github.com/junegunn/fzf
" 要: fzf.vim
" └https://github.com/junegunn/fzf.vim
" 設定の参照元:
" └https://qiita.com/youichiro/items/b4748b3e96106d25c5bc#%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E6%A4%9C%E7%B4%A2%E3%81%99%E3%82%8B
"
" Ctrl+pでファイル検索を開く
" git管理されていれば:GFiles、そうでなければ:Filesを実行する
fun! FzfOmniFiles()
  let is_git = system('git status')
  if v:shell_error
    :Files
  else
    :GFiles
  endif
endfun
nnoremap <C-p> :call FzfOmniFiles()<CR>

" Ctrl+gで文字列検索を開く
" <S-?>でプレビューを表示/非表示する
command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\ 'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
\ <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 3..'}, 'up:60%')
\ : fzf#vim#with_preview({'options': '--exact --delimiter : --nth 3..'}, 'right:50%:hidden', '?'),
\ <bang>0)
nnoremap <C-g> :Rg<CR>

" frでカーソル位置の単語をファイル検索する
nnoremap fr vawy:Rg <C-R>"<CR>
" frで選択した単語をファイル検索する
xnoremap fr y:Rg <C-R>"<CR>

" fbでバッファ検索を開く
nnoremap fb :Buffers<CR>
" fpでバッファの中で1つ前に開いたファイルを開く
nnoremap fp :Buffers<CR><CR>
" flで開いているファイルの文字列検索を開く
nnoremap fl :BLines<CR>
" fmでマーク検索を開く
nnoremap fm :Marks<CR>
" fhでファイル閲覧履歴検索を開く
nnoremap fh :History<CR>
" fcでコミット履歴検索を開く
nnoremap fc :Commits<CR>

" タグファイル生成
" 要: universal-ctags
" └https://ctags.io/
" タグファイル生成
nnoremap <C-c><C-t> :!ctags -R -f .tags<CR>
" タグファイルセット
nnoremap <C-s><C-t> :set tags=.tags<CR>

