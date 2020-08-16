set encoding=utf-8
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
"set cursorcolumn
set ruler
set showcmd
set wildmenu
set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

"┌─────────────────────────────────────────┐
"│ neocomplcache                           │ 
"└─────────────────────────────────────────┘
" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<TAB>"
  else
    if pumvisible()
      return "\<C-N>"
    else
      return "\<C-N>\<C-P>"
    end
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

"[汎用的な補完を行う]
" 補完を有効にする
let g:neocomplete#enable_at_startup = 1

" 補完に時間がかかってもスキップしない
let g:neocomplete#skip_auto_completion_time = ""

"[高度なコード補完を行う]
" 非同期ではなくて同期処理で補完する
let g:marching_backend = "sync_clang_command"

" オプションの設定
" これは clang のコマンドに渡される
let g:marching_clang_command_option="-std=c++1y"

" neocomplete.vim と併用して使用する場合
" neocomplete.vim を使用すれば自動補完になる
let g:marching_enable_neocomplete = 1

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_omni_input_patterns.cpp =
    \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

"┌─────────────────────────────────────────┐
"│neosnippet                               │
"└─────────────────────────────────────────┘
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

"┌─────────────────────────────────────────┐
"│折りたたみ                               │
"└─────────────────────────────────────────┘
set foldmethod=syntax
let perl_fold=1
set foldlevel=100

" 改行時のコメントを無効にする
autocmd FileType * setlocal formatoptions-=ro

"┌─────────────────────────────────────────┐
"│ファンクションキーの割当て               │
"└─────────────────────────────────────────┘
" F2で右にファイラ画面を表示したり閉じたりする
nnoremap <F2> :NERDTreeToggle<CR>
" バッファ一覧を表示する
noremap <F12> :BufExplorer<CR>

"┌─────────────────────────────────────────┐
"│vim-hybrid の適用                        │
"└─────────────────────────────────────────┘
let g:hybrid_use_Xresources = 1

"┌─────────────────────────────────────────┐
"│netrwの設定                              │
"└─────────────────────────────────────────┘
" netrwは常にtree view
let g:netrw_liststyle = 3
" CVSと.で始まるファイルは表示しない
let g:netrw_list_hide = 'CVS,\(^\|\s\s\)\zs\.\S\+'
" 'v'でファイルを開くときは右側に開く。(デフォルトが左側なので入れ替え)
let g:netrw_altv = 1
" 'o'でファイルを開くときは下側に開く。(デフォルトが上側なので入れ替え)
let g:netrw_alto = 1

"┌─────────────────────────────────────────┐
"│NERDTree の設定                          │
"└─────────────────────────────────────────┘
""最後に残ったウィンドウがNERDTREEのみのときはvimを閉じる
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeDirArrows=0
let g:NERDTreeMouseMode=0

" 引数なしで実行したとき、NERDTreeを実行する
let file_name = expand("%:p")
if has('vim_starting') &&  file_name == ""
    autocmd VimEnter * call ExecuteNERDTree()
endif

" カーソルが外れているときは自動的にnerdtreeを隠す
function! ExecuteNERDTree()
    "b:nerdstatus = 1 : NERDTree 表示中
    "b:nerdstatus = 2 : NERDTree 非表示中

    if !exists('g:nerdstatus')
        "execute 'NERDTree ~/'
        let g:windowWidth = winwidth(winnr())
        let g:nerdtreebuf = bufnr('')
        let g:nerdstatus = 1

    elseif g:nerdstatus == 1
        execute 'wincmd t'
        execute 'vertical resize' 0
        execute 'wincmd p'
        let g:nerdstatus = 2
    elseif g:nerdstatus == 2
        execute 'wincmd t'
        execute 'vertical resize' g:windowWidth
        let g:nerdstatus = 1

    endif
endfunction
noremap <c-e> :<c-u>:call ExecuteNERDTree()<cr>

"┌─────────────────────────────────────────┐
"│括弧の自動補完                           │
"└─────────────────────────────────────────┘
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

"┌─────────────────────────────────────────┐
"│minibufexpl.vim                          │
"└─────────────────────────────────────────┘
"タブエディタ風にバッファ管理ウィンドウを表示
:let g:miniBufExplMapWindowNavVim = 1
:let g:miniBufExplMapWindowNavArrows = 1
:let g:miniBufExplMapCTabSwitchBuffs = 1

"┌─────────────────────────────────────────┐
"│ファイル保存                             │
"└─────────────────────────────────────────┘
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

"┌─────────────────────────────────────────┐
"│for Vue.js                               │
"└─────────────────────────────────────────┘
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

"┌─────────────────────────────────────────┐
"│for NeoBundle                            │
"│https://github.com/Shougo/neobundle.vim  │
"└─────────────────────────────────────────┘
" Required:
set runtimepath^=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!
NeoBundle 'posva/vim-vue'

" Explorer
NeoBundle 'scrooloose/nerdtree'

" like tab editor
NeoBundle 'fholgado/minibufexpl.vim'

" for neosnippet
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

"┌─────────────────────────────────────────┐
"│for vim-plug                             │
"│https://github.com/junegunn/vim-plugvim  │
"└─────────────────────────────────────────┘
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
Plug 'Shougo/deoplete.nvim'
Plug 'lighttiger2505/deoplete-vim-lsp'

" Initialize plugin system
call plug#end()

