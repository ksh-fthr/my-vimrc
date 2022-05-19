" 環境別設定
if !has('mac')
    set guifontwide=MyricaM\ 16  " 全角文字 要: (MyricaM https://myrica.estable.jp/myricamhistry/)
endif
if has('mac')
    set columns=200
    set lines=70
endif

" 共通設定
set guifont=MyricaM\ 16  " 半角文字 要: (MyricaM https://myrica.estable.jp/myricamhistry/) 
set guioptions+=a

""=========================================
" 各種設定ファイルの読み込み
""=========================================
source <sfile>:h/.vim/settings/plugin/vesession-settings.vim    " セッションの設定
source <sfile>:h/.vim/settings/plugin/fern-vim-settings.vim     " Fern の設定
source <sfile>:h/.vim/settings/one/buffer-close-settings.vim    " バッファを閉じる設定

