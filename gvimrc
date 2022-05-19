" 環境別設定
if has('unix')
    set guifontwide=MyricaM\ M\ 16  " 全角文字 要: (MyricaM https://myrica.estable.jp/myricamhistry/)
    set guifont=MyricaM\ M\ 16      " 半角文字 要: (MyricaM https://myrica.estable.jp/myricamhistry/) 
    set columns=170
    set lines=45
endif
if has('mac')
    set guifontwide=Cica:h16  " 全角文字 要: (Cica https://github.com/miiton/Cica/releases)
    set guifont=Cica:h16      " 半角文字 要: (Cica https://github.com/miiton/Cica/releases)
    set columns=200
    set lines=70
endif

" 共通設定
set guioptions+=a

""=========================================
" 各種設定ファイルの読み込み
""=========================================
source <sfile>:h/.vim/settings/plugin/vesession-settings.vim    " セッションの設定
source <sfile>:h/.vim/settings/plugin/fern-vim-settings.vim     " Fern の設定
source <sfile>:h/.vim/settings/one/buffer-close-settings.vim    " バッファを閉じる設定

