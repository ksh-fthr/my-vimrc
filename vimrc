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
set guifontwide=Monospace\ 16  " linux 環境, 全角文字
set guifont=Monospace\ 16   " linux 環境, 半角文字

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
" タブラインの設定
" 要: vim-airline
" https://github.com/vim-airline/vim-airline
""=========================================
" 参考: https://www.reddit.com/r/vim/comments/crs61u/best_airline_settings/
let g:airline#extensions#tabline#enabled = 1           " enable airline tabline                                                           
let g:airline#extensions#tabline#show_close_button = 0 " remove 'X' at the end of the tabline                                            
let g:airline#extensions#tabline#tabs_label = ''       " can put text here like BUFFERS to denote buffers (I clear it so nothing is shown)
let g:airline#extensions#tabline#buffers_label = ''    " can put text here like TABS to denote tabs (I clear it so nothing is shown)      
let g:airline#extensions#tabline#fnamemod = ':t'       " disable file paths in the tab                                                    
let g:airline#extensions#tabline#show_tab_count = 0    " dont show tab numbers on the right                                                           
let g:airline#extensions#tabline#show_buffers = 1      " dont show buffers in the tabline                                                 
let g:airline#extensions#tabline#tab_min_count = 1     " minimum of 2 tabs needed to display the tabline                                  
let g:airline#extensions#tabline#show_splits = 0       " disables the buffer name that displays on the right of the tabline               
let g:airline#extensions#tabline#show_tab_nr = 0       " disable tab numbers                                                              
let g:airline#extensions#tabline#show_tab_type = 0     " disables the weird ornage arrow on the tabline

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
" Fern の設定
""=========================================
" Fern 上でドットファイルを表示する
let g:fern#default_hidden=1

" vim 起動時に fern を起動する
augroup __fern__
  au!
  autocmd VimEnter * ++nested Fern . -drawer -stay -keep -toggle -reveal=%
augroup END

" アイコン表示
let g:fern#renderer = 'nerdfont'

" アイコンに色をつける
augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END

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
" ファイラのリロード
" 要: fern-mapping-reload-all.vim
" https://github.com/LumaKernel/fern-mapping-reload-all.vim
""=========================================
function s:init_fern_mapping_reload_all()
    nmap <buffer> R <Plug>(fern-action-reload:all)
endfunction
augroup my-fern-mapping-reload-all
    autocmd! *
    autocmd FileType fern call s:init_fern_mapping_reload_all()
augroup END

""=========================================
" ファイルフォーマッタ
" 要: ALE (Asynchronous Lint Engine) 
" https://github.com/dense-analysis/ale
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
" Vue のシンタックスハイライト
" 要: posva/vim-vue
" https://github.com/posva/vim-vue
""=========================================
let g:vue_pre_processors = 'detect_on_enter'

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
" Initialize plugin system
call plug#end()

""=========================================
" ファンクションキーの割当て
""=========================================
" TBD...

