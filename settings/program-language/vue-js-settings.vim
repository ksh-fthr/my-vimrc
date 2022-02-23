""=========================================
" for Vue.js
""=========================================
"ファイルタイプの検索を有効にする
filetype plugin on
"ファイルタイプに合わせたインデントを利用する
filetype indent on
"シンタックスやインデントの設定
"sw=shiftwidth, sts=softtabstop, ts=tabstop, et=expandtabの略
autocmd FileType vue syntax sync fromstart 
autocmd FileType vue setlocal sw=2 sts=2 ts=2 et

" Vue のシンタックスハイライト
" 要: posva/vim-vue
" └https://github.com/posva/vim-vue
let g:vue_pre_processors = 'detect_on_enter'

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

