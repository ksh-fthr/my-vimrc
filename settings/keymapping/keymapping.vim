""/////////////////////////////////////////
" キーマッピング
""/////////////////////////////////////////
" セッション管理のキーマップ
nnoremap ss :SaveSession<CR>
nnoremap ls :LoadSession<CR>
nnoremap ds :DeleteSession<CR>
" バッファ(タブ)切り替えのキーマップ
nmap <C-j> <Plug>AirlineSelectPrevTab
nmap <C-k> <Plug>AirlineSelectNextTab
""=========================================
" バッファを閉じた際にウィンドウはそのままとする
" 要: vim-bufkill
" └https://github.com/qpkorr/vim-bufkill
""=========================================
" バッファを閉じる
" vim-bufkill を使用する場合はこちらを有効にする
nmap <C-d> :BD<CR>

""=========================================
" バッファを閉じた際にウィンドウはそのままとする
" └https://lsifrontend.blog.fc2.com/blog-entry-356.html
""=========================================
nmap <C-x> :Ebd<CR>

""=========================================
" git 関連
" 要: vim-gitgutter
" └https://github.com/airblade/vim-gitgutter
""=========================================
" ghでdiffをハイライトする
nnoremap gh :GitGutterLineHighlightsToggle<CR>
" gpでカーソル行のdiffを表示する
nnoremap gp :GitGutterPreviewHunk<CR>
" nh を押せば次のハンク（変更点のかたまり）へ、ph を押せば前のハンクへ移動
nnoremap nh :GitGutterNextHunk<CR>
nnoremap ph :GitGutterPrevHunk<CR>

""=========================================
" ファイル検索
" 要: fzf
" └https://github.com/junegunn/fzf
" 要: fzf.vim
" └https://github.com/junegunn/fzf.vim
" 設定の参照元:
" └https://qiita.com/youichiro/items/b4748b3e96106d25c5bc#%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E6%A4%9C%E7%B4%A2%E3%81%99%E3%82%8B
""=========================================
" Ctrl+pでファイル検索を開く
" git管理されていれば:GFiles、そうでなければ:Filesを実行する
fun! FzfOmniFiles()
  let is_git = system('git status')
  if v:shell_error
    :Files
  else
    :GFiles
  endif
endfun
nnoremap <C-p> :call FzfOmniFiles()<CR>

" Ctrl+gで文字列検索を開く
" <S-?>でプレビューを表示/非表示する
command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\ 'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
\ <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 3..'}, 'up:60%')
\ : fzf#vim#with_preview({'options': '--exact --delimiter : --nth 3..'}, 'right:50%:hidden', '?'),
\ <bang>0)
nnoremap <C-g> :Rg<CR>

" frでカーソル位置の単語をファイル検索する
nnoremap fr vawy:Rg <C-R>"<CR>
" frで選択した単語をファイル検索する
xnoremap fr y:Rg <C-R>"<CR>

" fbでバッファ検索を開く
nnoremap fb :Buffers<CR>
" fpでバッファの中で1つ前に開いたファイルを開く
nnoremap fp :Buffers<CR><CR>
" flで開いているファイルの文字列検索を開く
nnoremap fl :BLines<CR>
" fmでマーク検索を開く
nnoremap fm :Marks<CR>
" fhでファイル閲覧履歴検索を開く
nnoremap fh :History<CR>
" fcでコミット履歴検索を開く
nnoremap fc :Commits<CR>

" タグファイル生成
" 要: universal-ctags
" └https://ctags.io/
" タグファイル生成
nnoremap <C-c><C-t> :!ctags -R -f .tags<CR>
" タグファイルセット
nnoremap <C-s><C-t> :set tags=.tags<CR>

" Python の エラー、ワーニングの内容を確認
nnoremap <C-l><C-d> :LspDocumentDiagnostics<CR>

""=========================================
" マークダウンをプレビューする設定
" 要:  preview-markdown.vim
" └https://github.com/skanehira/preview-markdown.vim
" 
" 更に上記 plugin に必要なもの
" └https://github.com/MichaelMure/mdr
""=========================================
" 新しいウィンドウを右に開く
"set splitright
" プレビューを開く
"nnoremap <C-p><C-m> :PreviewMarkdown<CR>

""=========================================
" マークダウンをプレビューする設定
" 要:  markdown-preview.nvim
" └https://github.com/iamcco/markdown-preview.nvim
" 
""=========================================
""" Config
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

""" Key Mapping
" normal/insert
nmap <C-m> <Plug>MarkdownPreview
nmap <M-s> <Plug>MarkdownPreviewStop
nmap <C-o> <Plug>MarkdownPreviewToggle

""=========================================
" open-browser.vim の設定
" 要: open-browser.vim
" └https://github.com/tyru/open-browser.vim
""=========================================
" URL にカーソルがある状態で `gx` -> ブラウザで URL が開く
" 文字列にカーソルがある状態で `gx` -> ブラウザ上で google 検索
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
nnoremap <Leader>o :<C-u>execute "OpenBrowser" "file:///" . expand('%:p:gs?\\?/?')<CR>

""=========================================
" ファイラのリロード
" 要: fern-mapping-reload-all.vim
" └https://github.com/LumaKernel/fern-mapping-reload-all.vim
""=========================================
function s:init_fern_mapping_reload_all()
    nmap <buffer> <C-r> <Plug>(fern-action-reload:all)
endfunction
augroup __fern-mapping-reload-all__
    autocmd! *
    autocmd FileType fern call s:init_fern_mapping_reload_all()
augroup END

""=========================================
" vim-lsp の定義ジャンプのキーバインド
" 要: vim-lsp
" └https://github.com/prabirshrestha/vim-lsp
""=========================================
nnoremap <expr> <C-]> execute('LspPeekDefinition') =~ "not supported" ? "\<C-]>" : ":LspDefinition<cr>"

""/////////////////////////////////////////
" fern-preview.vim のキーバインド
" 要: fern-preview.vim
" └ https://github.com/yuki-yano/fern-preview.vim
""/////////////////////////////////////////
" 公式リポジトリを参考にキーマップを追加
function! s:fern_settings() abort
  nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
  " ファイル検索のキーバインドと競合するのでコメントアウト
  "nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
  " バッファを閉じる操作のキーバインドと競合するのでデフォルトの設定から割り当てるキーを変更.
  nmap <silent> <buffer> <C-j> <Plug>(fern-action-preview:scroll:down:half)
  nmap <silent> <buffer> <C-k> <Plug>(fern-action-preview:scroll:up:half)
endfunction

augroup fern-settings
  autocmd!
  autocmd FileType fern call s:fern_settings()
augroup END

