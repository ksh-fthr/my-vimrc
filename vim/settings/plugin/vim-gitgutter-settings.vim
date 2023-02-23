""=========================================
" git 関連
" 要: vim-gitgutter
" └https://github.com/airblade/vim-gitgutter
""=========================================
" 常に変更箇所の記号を表示する
set signcolumn=yes

" タイピング停止時から反映されるまでの時間(msec)を設定
set updatetime=250

" 変更差分を示す記号を設定
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '<'

" 記号の色を変更する
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=blue
highlight GitGutterDelete ctermfg=red

