""=========================================
" ファイルフォーマッタ
" 要: ALE (Asynchronous Lint Engine) 
" └https://github.com/dense-analysis/ale
""=========================================
" Set this variable to 1 to fix files when you save them.
let b:ale_linter_aliases = ['javascript', 'vue']
let b:ale_linters = ['eslint', 'vls']
let b:ale_fixers = {'javascript': ['prettier', 'eslint'],'vue': ['eslint', 'vls']}
let b:ale_linters = {'javascript': ['prettier', 'eslint'],'vue': ['eslint', 'vls']}
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" Write this in your vimrc file
"let g:ale_lint_on_text_changed = 'never'
"let g:ale_lint_on_insert_leave = 0
" if you don't want linters to run on opening a file
"let g:ale_lint_on_enter = 0
let g:ale_linters_explicit = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_fix_on_save = 1

