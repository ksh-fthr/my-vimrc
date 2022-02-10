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
" 要: vim-airline
" └https://github.com/vim-airline/vim-airline
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
let g:airline_theme = 'wombat'
let g:airline_powerline_fonts=1
" ステータスライン上に git branch を表示する
let g:airline#extensions#hunks#enabled=0
let g:airline#extensions#branch#enabled=1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

""=========================================
" Fern の設定
""=========================================
source <sfile>:h/.fern-vim-settings.vim

