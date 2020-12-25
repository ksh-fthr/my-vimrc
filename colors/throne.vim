set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "throne"

hi Normal                       ctermfg=231     ctermbg=235     cterm=NONE          guifg=#f8f8f2   guibg=#272822   gui=NONE
hi Character                    ctermfg=141     ctermbg=NONE    cterm=NONE          guifg=#ae81ff   guibg=NONE      gui=NONE
hi Comment                      ctermfg=242     ctermbg=NONE    cterm=NONE          guifg=#75715e   guibg=NONE      gui=NONE
"hi Comment                      ctermfg=242     ctermbg=NONE    cterm=NONE          guifg=#c0c0c0   guibg=NONE      gui=NONE

hi Visual                       ctermfg=NONE    ctermbg=59      cterm=NONE          guifg=NONE      guibg=#49483e   gui=NONE
hi ColorColumn                  ctermfg=NONE    ctermbg=237     cterm=NONE          guifg=NONE      guibg=#3c3d37   gui=NONE
hi LineNr                       ctermfg=102     ctermbg=237     cterm=NONE          guifg=#90908a   guibg=NONE      gui=NONE
hi MatchParen                   ctermfg=197     ctermbg=NONE    cterm=underline     guifg=#f92672   guibg=NONE      gui=underline
hi Pmenu                        ctermfg=NONE    ctermbg=NONE    cterm=NONE          guifg=NONE      guibg=NONE      gui=NONE
hi PmenuSel                     ctermfg=NONE    ctermbg=59      cterm=NONE          guifg=NONE      guibg=#49483e   gui=NONE
hi IncSearch                    ctermfg=235     ctermbg=186     cterm=NONE          guifg=#272822   guibg=#e6db74   gui=NONE
hi Search                       ctermfg=NONE    ctermbg=NONE    cterm=underline     guifg=NONE      guibg=NONE      gui=underline
hi Directory                    ctermfg=141     ctermbg=NONE    cterm=NONE          guifg=#ae81ff   guibg=NONE      gui=NONE
hi Folded                       ctermfg=242     ctermbg=235     cterm=NONE          guifg=#75715e   guibg=#272822   gui=NONE
hi Boolean                      ctermfg=141     ctermbg=NONE    cterm=NONE          guifg=#ae81ff   guibg=NONE      gui=NONE
hi Conditional                  ctermfg=197     ctermbg=NONE    cterm=NONE          guifg=#f92672   guibg=NONE      gui=NONE
hi Constant                     ctermfg=NONE    ctermbg=NONE    cterm=NONE          guifg=NONE      guibg=NONE      gui=NONE
hi Define                       ctermfg=197     ctermbg=NONE    cterm=NONE          guifg=#f92672   guibg=NONE      gui=NONE
hi DiffAdd                      ctermfg=231     ctermbg=64      cterm=none          guifg=#f8f8f2   guibg=#46830c   gui=none
hi DiffDelete                   ctermfg=88      ctermbg=NONE    cterm=NONE          guifg=#8b0807   guibg=NONE      gui=NONE
hi DiffChange                   ctermfg=231     ctermbg=23      cterm=NONE          guifg=#f8f8f2   guibg=#243955   gui=NONE
hi DiffText                     ctermfg=231     ctermbg=24      cterm=none          guifg=#f8f8f2   guibg=#204a87   gui=none
hi ErrorMsg                     ctermfg=231     ctermbg=197     cterm=NONE          guifg=#f8f8f0   guibg=#f92672   gui=NONE
hi WarningMsg                   ctermfg=231     ctermbg=197     cterm=NONE          guifg=#f8f8f0   guibg=#f92672   gui=NONE
hi Float                        ctermfg=141     ctermbg=NONE    cterm=NONE          guifg=#ae81ff   guibg=NONE      gui=NONE
hi Function                     ctermfg=148     ctermbg=NONE    cterm=NONE          guifg=#a6e22e   guibg=NONE      gui=NONE
hi Identifier                   ctermfg=81      ctermbg=NONE    cterm=NONE          guifg=#66d9ef   guibg=NONE      gui=none
hi Keyword                      ctermfg=197     ctermbg=NONE    cterm=NONE          guifg=#f92672   guibg=NONE      gui=NONE
hi Label                        ctermfg=186     ctermbg=NONE    cterm=NONE          guifg=#e6db74   guibg=NONE      gui=NONE
hi NonText                      ctermfg=59      ctermbg=236     cterm=NONE          guifg=#49483e   guibg=#31322c   gui=NONE
hi Number                       ctermfg=141     ctermbg=NONE    cterm=NONE          guifg=#ae81ff   guibg=NONE      gui=NONE
hi Operator                     ctermfg=197     ctermbg=NONE    cterm=NONE          guifg=#f92672   guibg=NONE      gui=NONE
hi PreProc                      ctermfg=197     ctermbg=NONE    cterm=NONE          guifg=#f92672   guibg=NONE      gui=NONE
hi Special                      ctermfg=231     ctermbg=NONE    cterm=NONE          guifg=#f8f8f2   guibg=NONE      gui=NONE
hi SpecialKey                   ctermfg=59      ctermbg=237     cterm=NONE          guifg=#49483e   guibg=#3c3d37   gui=NONE
hi Structure                                                                        guifg=#66D9EF
hi Statement                    ctermfg=197     ctermbg=NONE    cterm=NONE          guifg=#f92672   guibg=NONE      gui=NONE
hi StorageClass                 ctermfg=81      ctermbg=NONE    cterm=NONE          guifg=#66d9ef   guibg=NONE      gui=none
hi String                       ctermfg=186     ctermbg=NONE    cterm=NONE          guifg=#e6db74   guibg=NONE      gui=NONE
hi Tag                          ctermfg=197     ctermbg=NONE    cterm=NONE          guifg=#f92672   guibg=NONE      gui=NONE
hi Title                        ctermfg=231     ctermbg=NONE    cterm=none          guifg=#f8f8f2   guibg=NONE      gui=none
hi Todo                         ctermfg=95      ctermbg=NONE    cterm=inverse,none  guifg=#75715e   guibg=NONE      gui=inverse,none
hi Typedef                                                                          guifg=#66D9EF
hi Type                                                                             guifg=#66D9EF                   gui=none
hi Underlined                   ctermfg=NONE    ctermbg=NONE    cterm=underline     guifg=NONE      guibg=NONE      gui=underline
hi rubyClass                    ctermfg=197     ctermbg=NONE    cterm=NONE          guifg=#f92672   guibg=NONE      gui=NONE
hi rubyFunction                 ctermfg=148     ctermbg=NONE    cterm=NONE          guifg=#a6e22e   guibg=NONE      gui=NONE
hi rubyInterpolationDelimiter   ctermfg=NONE    ctermbg=NONE    cterm=NONE          guifg=NONE      guibg=NONE      gui=NONE
hi rubySymbol                   ctermfg=141     ctermbg=NONE    cterm=NONE          guifg=#ae81ff   guibg=NONE      gui=NONE
hi rubyConstant                 ctermfg=81      ctermbg=NONE    cterm=NONE          guifg=#66d9ef   guibg=NONE      gui=none
hi rubyStringDelimiter          ctermfg=186     ctermbg=NONE    cterm=NONE          guifg=#e6db74   guibg=NONE      gui=NONE
hi rubyBlockParameter           ctermfg=208     ctermbg=NONE    cterm=NONE          guifg=#fd971f   guibg=NONE      gui=none
hi rubyInstanceVariable         ctermfg=NONE    ctermbg=NONE    cterm=NONE          guifg=NONE      guibg=NONE      gui=NONE
hi rubyInclude                  ctermfg=197     ctermbg=NONE    cterm=NONE          guifg=#f92672   guibg=NONE      gui=NONE
hi rubyGlobalVariable           ctermfg=NONE    ctermbg=NONE    cterm=NONE          guifg=NONE      guibg=NONE      gui=NONE
hi rubyRegexp                   ctermfg=186     ctermbg=NONE    cterm=NONE          guifg=#e6db74   guibg=NONE      gui=NONE
hi rubyRegexpDelimiter          ctermfg=186     ctermbg=NONE    cterm=NONE          guifg=#e6db74   guibg=NONE      gui=NONE
hi rubyEscape                   ctermfg=141     ctermbg=NONE    cterm=NONE          guifg=#ae81ff   guibg=NONE      gui=NONE
hi rubyControl                  ctermfg=197     ctermbg=NONE    cterm=NONE          guifg=#f92672   guibg=NONE      gui=NONE
hi rubyClassVariable            ctermfg=NONE    ctermbg=NONE    cterm=NONE          guifg=NONE      guibg=NONE      gui=NONE
hi rubyOperator                 ctermfg=197     ctermbg=NONE    cterm=NONE          guifg=#f92672   guibg=NONE      gui=NONE
hi rubyException                ctermfg=197     ctermbg=NONE    cterm=NONE          guifg=#f92672   guibg=NONE      gui=NONE
hi rubyPseudoVariable           ctermfg=NONE    ctermbg=NONE    cterm=NONE          guifg=NONE      guibg=NONE      gui=NONE
hi rubyRailsUserClass           ctermfg=81      ctermbg=NONE    cterm=NONE          guifg=#66d9ef   guibg=NONE      gui=none
hi rubyRailsARAssociationMethod ctermfg=81      ctermbg=NONE    cterm=NONE          guifg=#66d9ef   guibg=NONE      gui=NONE
hi rubyRailsARMethod            ctermfg=81      ctermbg=NONE    cterm=NONE          guifg=#66d9ef   guibg=NONE      gui=NONE
hi rubyRailsRenderMethod        ctermfg=81      ctermbg=NONE    cterm=NONE          guifg=#66d9ef   guibg=NONE      gui=NONE
hi rubyRailsMethod              ctermfg=81      ctermbg=NONE    cterm=NONE          guifg=#66d9ef   guibg=NONE      gui=NONE
hi erubyDelimiter               ctermfg=NONE    ctermbg=NONE    cterm=NONE          guifg=NONE      guibg=NONE      gui=NONE
hi erubyComment                 ctermfg=95      ctermbg=NONE    cterm=NONE          guifg=#75715e   guibg=NONE      gui=NONE
hi erubyRailsMethod             ctermfg=81      ctermbg=NONE    cterm=NONE          guifg=#66d9ef   guibg=NONE      gui=NONE

hi htmlTag                      ctermfg=NONE    ctermbg=NONE    cterm=NONE          guifg=NONE      guibg=NONE      gui=NONE
hi htmlEndTag                   ctermfg=NONE    ctermbg=NONE    cterm=NONE          guifg=NONE      guibg=NONE      gui=NONE
hi htmlTagName                  ctermfg=NONE    ctermbg=NONE    cterm=NONE          guifg=#f92672   guibg=NONE      gui=NONE
hi htmlArg                      ctermfg=NONE    ctermbg=NONE    cterm=NONE          guifg=#a6e22e   guibg=NONE      gui=NONE
hi htmlSpecialChar              ctermfg=141     ctermbg=NONE    cterm=NONE          guifg=#ae81ff   guibg=NONE      gui=NONE

hi javaScriptFunction           ctermfg=81      ctermbg=NONE    cterm=NONE          guifg=#66d9ef   guibg=NONE      gui=none
hi javaScriptRailsFunction      ctermfg=81      ctermbg=NONE    cterm=NONE          guifg=#66d9ef   guibg=NONE      gui=NONE
hi javaScriptBraces             ctermfg=NONE    ctermbg=NONE    cterm=NONE          guifg=NONE      guibg=NONE      gui=NONE
hi yamlKey                      ctermfg=197     ctermbg=NONE    cterm=NONE          guifg=#f92672   guibg=NONE      gui=NONE
hi yamlAnchor                   ctermfg=NONE    ctermbg=NONE    cterm=NONE          guifg=NONE      guibg=NONE      gui=NONE
hi yamlAlias                    ctermfg=NONE    ctermbg=NONE    cterm=NONE          guifg=NONE      guibg=NONE      gui=NONE
hi yamlDocumentHeader           ctermfg=186     ctermbg=NONE    cterm=NONE          guifg=#e6db74   guibg=NONE      gui=NONE
hi cssURL                       ctermfg=208     ctermbg=NONE    cterm=NONE          guifg=#fd971f   guibg=NONE      gui=none
hi cssFunctionName              ctermfg=81      ctermbg=NONE    cterm=NONE          guifg=#66d9ef   guibg=NONE      gui=NONE
hi cssColor                     ctermfg=141     ctermbg=NONE    cterm=NONE          guifg=#ae81ff   guibg=NONE      gui=NONE
hi cssPseudoClassId             ctermfg=148     ctermbg=NONE    cterm=NONE          guifg=#a6e22e   guibg=NONE      gui=NONE
hi cssClassName                 ctermfg=148     ctermbg=NONE    cterm=NONE          guifg=#a6e22e   guibg=NONE      gui=NONE
hi cssValueLength               ctermfg=141     ctermbg=NONE    cterm=NONE          guifg=#ae81ff   guibg=NONE      gui=NONE
hi cssCommonAttr                ctermfg=81      ctermbg=NONE    cterm=NONE          guifg=#66d9ef   guibg=NONE      gui=NONE
hi cssBraces                    ctermfg=NONE    ctermbg=NONE    cterm=NONE          guifg=NONE      guibg=NONE      gui=NONE

" Split area
hi StatusLine   gui=NONE guifg=#000000 guibg=#c4c4c4
hi StatusLineNC gui=NONE guifg=#707070 guibg=#c4c4c4
hi VertSplit    gui=NONE guifg=#707070 guibg=#c4c4c4
hi WildMenu     gui=NONE guifg=#000000 guibg=#ff80c0

" Cursor
hi Cursor       ctermfg=234     ctermbg=250                    gui=None        guifg=#1c1c1c       guibg=#bcbcbc
hi CursorColumn                 ctermbg=235     cterm=none     gui=None        guifg=NONE          guibg=#e6e6fa
hi CursorLine                   ctermbg=235     cterm=none     gui=None        guifg=NONE          guibg=#3c3d37

"-------------------------------------------------------------------------------------------------------------------------------
" C/C++ 用のハイライト
" cpp.vim へ以下を追記しておくことで有効になる
"-------------------------------------------------------------------------------------------------------------------------------
" ▼ 追記コード ▼
" Highlight Class and Function names
"syn match    cCustomParen    "(" contains=cParen contains=cCppParen
"syn match    cCustomFunc     "\w\+\s*(" contains=cCustomParen
"syn match    cCustomScope    "::"
"syn match    cCustomClass    "\w\+\s*::" contains=cCustomScope
"hi def link cCustomFunc  Function
"hi def link cCustomClass Function
"-------------------------------------------------------------------------------------------------------------------------------
hi cCustomFunc                                                 gui=NONE        guifg=#66D9EF
hi cCustomClass                                                gui=NONE        guifg=yellowgreen
