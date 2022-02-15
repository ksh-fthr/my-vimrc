set guifontwide=MyricaM\ 16  " 全角文字 要: (MyricaM https://myrica.estable.jp/myricamhistry/)
set guifont=MyricaM\ 16  " 半角文字 要: (MyricaM https://myrica.estable.jp/myricamhistry/) 
set guioptions+=a

""=========================================
" セッションの設定
" 要: skanehira/vesession
" └https://github.com/skanehira/vsession
""=========================================
augroup __load_session__
  autocmd VimEnter * LoadSession
augroup END

""=========================================
" タブラインの設定
""=========================================
source <sfile>:h/.vim-airline-settings.vim

""=========================================
" Fern の設定
""=========================================
source <sfile>:h/.fern-vim-settings.vim

