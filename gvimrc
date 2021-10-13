set guifontwide=MyricaM\ 16  " 全角文字 要: (MyricaM https://myrica.estable.jp/myricamhistry/)
set guifont=MyricaM\ 16  " 半角文字 要: (MyricaM https://myrica.estable.jp/myricamhistry/) 

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
" 要: fern.vim
" └https://github.com/lambdalisue/fern.vim
""=========================================
" Fern 上でドットファイルを表示する
let g:fern#default_hidden=1

" vim 起動時に fern を起動する
augroup __fern__
  au!
  autocmd VimEnter * ++nested Fern . -drawer -stay -keep -toggle -reveal=%
augroup END

" アイコン表示
" 要: nerd-fonts
" └https://github.com/ryanoasis/nerd-fonts
"
" 要: nerdfont.vim
" └https://github.com/lambdalisue/nerdfont.vim
"
" 要: fern-renderer-nerdfont.vim
" └https://github.com/lambdalisue/fern-renderer-nerdfont.vim
set ambiwidth=double "全角記号を正しく表示する
let g:fern#renderer = 'nerdfont'

" アイコンに色をつける
" 要: glyph-palette.vim
" └https://github.com/lambdalisue/glyph-palette.vim
augroup __glyph-palette__
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END

""=========================================
" git の差分を fern 上に表示する
" 要: fern-git-status.vim
" └https://github.com/lambdalisue/fern-git-status.vim
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
" キーマッピング
""=========================================
" セッション管理のキーマップ
nnoremap ss :SaveSession<CR>
nnoremap ls :LoadSession<CR>
nnoremap ds :DeleteSession<CR>
" バッファ(タブ)切り替えのキーマップ
nmap <C-j> <Plug>AirlineSelectPrevTab
nmap <C-k> <Plug>AirlineSelectNextTab
" バッファを閉じる
nmap <C-d> :bd<CR>

" ファイラのリロード
" 要: fern-mapping-reload-all.vim
" └https://github.com/LumaKernel/fern-mapping-reload-all.vim
function s:init_fern_mapping_reload_all()
    nmap <buffer> R <Plug>(fern-action-reload:all)
endfunction
augroup __fern-mapping-reload-all__
    autocmd! *
    autocmd FileType fern call s:init_fern_mapping_reload_all()
augroup END

