set guifontwide=MyricaM\ 16  " 全角文字 要: (MyricaM https://myrica.estable.jp/myricamhistry/)

""=========================================
" セッションの設定
" 要: skanehira/vesession
" https://github.com/skanehira/vsession
""=========================================
augroup __load_session__
  autocmd VimEnter * LoadSession
augroup END

nnoremap ss :SaveSession<CR>
nnoremap ls :LoadSession<CR>
nnoremap ds :DeleteSession<CR>

""=========================================
" Fern の設定
" 要: fern.vim
" https://github.com/lambdalisue/fern.vim
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
" https://github.com/ryanoasis/nerd-fonts
"
" 要: nerdfont.vim
" https://github.com/lambdalisue/nerdfont.vim
"
" 要: fern-renderer-nerdfont.vim
" https://github.com/lambdalisue/fern-renderer-nerdfont.vim
set ambiwidth=double "全角記号を正しく表示する "全角記号を正しく表示する
let g:fern#renderer = 'nerdfont'

" アイコンに色をつける
" 要: glyph-palette.vim
" https://github.com/lambdalisue/glyph-palette.vim
augroup __glyph-palette__
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
augroup __fern-mapping-reload-all__
    autocmd! *
    autocmd FileType fern call s:init_fern_mapping_reload_all()
augroup END

