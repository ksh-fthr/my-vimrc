""=========================================
" 主だった設定
""=========================================
" 環境別設定
if has('unix')
    set guifontwide=MyricaM\ M\ 16  " 全角文字 要: (MyricaM https://myrica.estable.jp/myricamhistry/)
    set guifont=MyricaM\ M\ 16      " 半角文字 要: (MyricaM https://myrica.estable.jp/myricamhistry/)
    set columns=170
    set lines=45
endif
if has('mac')
    set guifontwide=MyricaM\ M:h16  " 全角文字 要: (MyricaM https://myrica.estable.jp/myricamhistry/)
    set guifont=MyricaM\ M:h16      " 半角文字 要: (MyricaM https://myrica.estable.jp/myricamhistry/)
endif

" 共通設定
set encoding=utf-8
source $VIMRUNTIME/delmenu.vim
set langmenu=ja_jp.utf-8
source $VIMRUNTIME/menu.vim
set fileencodings=utf-8
set fileformats=unix
set nu
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
set clipboard=unnamedplus " ヤンクした内容をクリップボードと共有
set clipboard+=autoselect

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
" 各種設定ファイルの読み込み
""=========================================
source <sfile>:h/.vim/settings/keymapping/keymapping.vim                " キーマッピング
source <sfile>:h/.vim/settings/plugin/vim-plug-settings.vim             " プラグイン管理
source <sfile>:h/.vim/settings/plugin/vim-gitgutter-settings.vim        " git 関連
source <sfile>:h/.vim/settings/plugin/ale-settings.vim                  " ファイルフォーマット
source <sfile>:h/.vim/settings/plugin/markdown-preview-settings.vim     " マークダウンプレビュー
source <sfile>:h/.vim/settings/plugin/vim-airline-settings.vim          " タブラインの設定
source <sfile>:h/.vim/settings/program-language/javascript-settings.vim " JavaScript
source <sfile>:h/.vim/settings/program-language/vue-js-settings.vim     " Vue.js

