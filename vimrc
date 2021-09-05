set encoding=utf-8
source $VIMRUNTIME/delmenu.vim
set langmenu=ja_jp.utf-8
source $VIMRUNTIME/menu.vim
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileformats=unix,dos,mac
set nu
set columns=180
set lines=50
set noundofile
set nobackup
set noundofile
set ts=4 sw=4 tw=0 expandtab
set nowrap
set cmdheight=2
set cursorline
set ruler
set showcmd
set wildmenu
set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
set showtabline=2
set guifontwide=Monospace\ 14  " linux 環境, 全角文字
set guifont=Monospace\ 14      " linux 環境, 半角文字

colorscheme zabanya


" 折りたたみ
set foldmethod=syntax
let perl_fold=1
set foldlevel=100

" 改行時のコメントを無効にする
autocmd FileType * setlocal formatoptions-=ro

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
" タブラインの設定
" 要: vim-airline
" https://github.com/vim-airline/vim-airline
""=========================================
let g:airline#extensions#tabline#enabled = 1

""=========================================
" git 操作
" 要: vim-gitgutter
" https://github.com/airblade/vim-gitgutter
""=========================================
" ghでdiffをハイライトする
nnoremap gh :GitGutterLineHighlightsToggle<CR>
" gpでカーソル行のdiffを表示する
nnoremap gp :GitGutterPreviewHunk<CR>
" 記号の色を変更する
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=blue
highlight GitGutterDelete ctermfg=red

""=========================================
" git の差分を fern 上に表示する
" 要: fern-git-status.vim
" https://github.com/lambdalisue/fern-git-status.vim
""=========================================
" Disable listing ignored files/directories
let g:fern_git_status#disable_ignored = 1

" Disable listing untracked files
let g:fern_git_status#disable_untracked = 1

" Disable listing status of submodules
let g:fern_git_status#disable_submodules = 1

" Disable listing status of directories
let g:fern_git_status#disable_directories = 1


"" 反映時間を短くする(デフォルトは4000ms)
set updatetime=250

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
augroup vimrc-auto-mkdir  " {{{
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
" https://github.com/junegunn/vim-plug
""=========================================
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

  " vim-list
  " https://github.com/mattn/vim-lsp-settings
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  Plug 'posva/vim-vue'
  " ファイラ
  Plug 'lambdalisue/fern.vim'
  " ファイルツリー上に git 差分を表示
  Plug 'lambdalisue/fern-git-status.vim'
  " git 差分
  Plug 'airblade/vim-gitgutter'
  " ステータスバー
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
" Initialize plugin system
call plug#end()

""=========================================
" ファンクションキーの割当て
""=========================================
" TBD...

