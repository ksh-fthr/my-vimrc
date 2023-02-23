""=========================================
" for JavaScript
""=========================================
"ファイルタイプの検索を有効にする
filetype plugin on
"ファイルタイプに合わせたインデントを利用する
filetype indent on
"シンタックスやインデントの設定
"sw=shiftwidth, sts=softtabstop, ts=tabstop, et=expandtabの略
autocmd FileType javascript  setlocal sw=2 sts=2 ts=2 et
autocmd FileType js          setlocal sw=2 sts=2 ts=2 et
autocmd FileType json        setlocal sw=2 sts=2 ts=2 et

""=========================================
" 要: javascript-libraries-syntax
" └https://github.com/othree/javascript-libraries-syntax.vim
""=========================================
let g:used_javascript_libs = 'jquery,underscore,react,flux,jasmine,d3'
autocmd BufReadPre *.js let b:javascript_lib_use_jquery = 1
autocmd BufReadPre *.js let b:javascript_lib_use_underscore = 1
autocmd BufReadPre *.js let b:javascript_lib_use_react = 1
autocmd BufReadPre *.js let b:javascript_lib_use_flux = 1
autocmd BufReadPre *.js let b:javascript_lib_use_jasmine = 1
autocmd BufReadPre *.js let b:javascript_lib_use_d3 = 1

""=========================================
" 要: vim-javascript
" └https://github.com/pangloss/vim-javascript
""=========================================
let g:javascript_plugin_jsdoc = 1
"let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1
augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END


