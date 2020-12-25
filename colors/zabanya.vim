set background=dark
if version > 580
    hi clear
    if exists("syntax_on")
    syntax reset
    endif
endif
let g:colors_name="zabanya"

hi Normal       ctermfg=250 ctermbg=234                         gui=None        guifg=#bcbcbc       guibg=#1c1c1c
hi Comment      ctermfg=242 ctermbg=NONE cterm=NONE             gui=NONE        guifg=#75715e       guibg=NONE
"hi Comment      ctermfg=242 ctermbg=NONE cterm=NONE             gui=NONE        guifg=#5f9ea0      guibg=NONE

hi LineNr       ctermfg=102 ctermbg=237 cterm=NONE              gui=NONE        guifg=#90908a       guibg=#1c1c1c
hi NonText      ctermfg=234 ctermbg=234                         gui=None        guifg=#1c1c1c       guibg=#1c1c1c

" Diff
hi DiffDelete   ctermfg=234 ctermbg=233                         gui=None        guifg=#1c1c1c       guibg=#121212
hi DiffAdd      ctermbg=236                                     gui=None        guibg=#303030
hi DiffChange   ctermbg=235                                     gui=None        guibg=#262626
hi DiffText     ctermfg=161 ctermbg=234 cterm=underline         gui=underline   guifg=#df005f       guibg=#1c1c1c

hi Visual       ctermfg=234 ctermbg=122                         gui=None        guifg=#1c1c1c       guibg=#87ffdf

hi Folded       ctermfg=244 ctermbg=235                         gui=None        guifg=#808080       guibg=#262626
hi FoldColumn   ctermfg=244 ctermbg=234                         gui=None        guifg=#808080       guibg=#1c1c1c

hi IncSearch    ctermfg=234 ctermbg=214 cterm=underline         gui=underline   guifg=#1c1c1c       guibg=#ffaf00
hi Search       ctermfg=234 ctermbg=214 cterm=none              gui=None        guifg=#1c1c1c       guibg=#ffaf00

hi ModeMsg      ctermfg=117 ctermbg=234 cterm=none              gui=none        guifg=#87dfff       guibg=#1c1c1c
hi MoreMsg      ctermfg=122 ctermbg=234 cterm=none              gui=None        guifg=#87ffdf       guibg=#1c1c1c
hi Question     ctermfg=122 ctermbg=234 cterm=none              gui=none        guifg=#87ffdf       guibg=#1c1c1c
hi WarningMsg   ctermfg=122 ctermbg=234 cterm=none              gui=None        guifg=#87ffdf       guibg=#1c1c1c
hi ErrorMsg     ctermfg=255 ctermbg=160 cterm=none              gui=None        guifg=#eeeeee       guibg=#df0000
hi Error        ctermfg=196 ctermbg=234 cterm=none              gui=None        guifg=#ff0000       guibg=#1c1c1c

hi SpecialKey   ctermfg=214 ctermbg=234                         gui=None        guifg=#ffaf00       guibg=#1c1c1c
hi Title        ctermfg=075 ctermbg=234 cterm=none              gui=none        guifg=#5fafff       guibg=#1c1c1c
hi Directory    ctermfg=117 ctermbg=234 cterm=none              gui=none        guifg=#87dfff       guibg=#1c1c1c

hi SignColumn   ctermfg=214 ctermbg=235                         gui=None        guifg=#ffaf00       guibg=#262626


hi MatchParen   ctermfg=196 ctermbg=234 cterm=none,reverse      gui=none,reverse    guifg=#ff0000       guibg=#1c1c1c

hi Tabline      ctermfg=245 ctermbg=235 cterm=underline         gui=underline   guifg=#8a8a8a       guibg=#262626
hi TablineSel   ctermfg=250 ctermbg=234 cterm=none              gui=none        guifg=#bcbcbc       guibg=#1c1c1c
hi TablineFill  ctermfg=250 ctermbg=237 cterm=underline         gui=underline   guifg=#bcbcbc       guibg=#3a3a3a

hi Pmenu        ctermfg=250 ctermbg=235 cterm=none              gui=None        guifg=#bcbcbc       guibg=#262626
hi PmenuSel     ctermfg=117 ctermbg=234 cterm=underline         gui=underline   guifg=#87dfff       guibg=#1c1c1c
hi PmenuSbar    ctermfg=116 ctermbg=234 cterm=none              gui=None        guifg=#87dfdf       guibg=#1c1c1c
hi PmenuThumb   ctermfg=116 ctermbg=116 cterm=none              gui=None        guifg=#87dfdf       guibg=#87dfdf

hi SpellBad     ctermfg=198 ctermbg=234 cterm=underline         gui=underline   guifg=#ff0087       guibg=#1c1c1c
hi SpellCap     ctermfg=198 ctermbg=234 cterm=none              gui=None        guifg=#ff0087       guibg=#1c1c1c
hi SpellRare    ctermfg=198 ctermbg=234 cterm=none              gui=None        guifg=#ff0087       guibg=#1c1c1c
hi SpellLocal   ctermfg=198 ctermbg=234 cterm=none              gui=None        guifg=#ff0087       guibg=#1c1c1c
hi ColorColumn ctermbg=235                                      gui=None        guibg=#262626

hi Constant   ctermfg=086 ctermbg=234                               gui=None        guifg=#5fffdf       guibg=#1c1c1c
hi Identifier ctermfg=080 ctermbg=234 cterm=none                    gui=none        guifg=#5fdfdf       guibg=#1c1c1c
hi String     ctermfg=074 ctermbg=234                               gui=None        guifg=#5fafdf       guibg=#1c1c1c
hi Statement  ctermfg=159 ctermbg=234 cterm=none                    gui=None        guifg=#afffff       guibg=#1c1c1c
hi PreProc    ctermfg=122 ctermbg=234                               gui=None        guifg=#87ffdf       guibg=#1c1c1c
hi Function   ctermfg=121 ctermbg=234 cterm=none                    gui=none        guifg=#87ffaf       guibg=#1c1c1c
hi Type       ctermfg=117 ctermbg=234 cterm=none                    gui=none        guifg=#87dfff       guibg=#1c1c1c
hi Special    ctermfg=050 ctermbg=234                               gui=None        guifg=#00ffdf       guibg=#1c1c1c
hi Delimiter  ctermfg=153 ctermbg=234                               gui=None        guifg=#afdfff       guibg=#1c1c1c
hi Number     ctermfg=086 ctermbg=234                               gui=None        guifg=#5fffdf       guibg=#1c1c1c
hi Ignore     ctermfg=214 ctermbg=234                               gui=None        guifg=#ffaf00       guibg=#1c1c1c
hi Todo       ctermfg=196 ctermbg=234                               gui=None        guifg=#ff0000       guibg=#1c1c1c
hi Exception  ctermfg=080 ctermbg=234 cterm=none                    gui=none        guifg=#5fdfdf       guibg=#1c1c1c

" Split area
hi StatusLine   gui=NONE guifg=#000000 guibg=#c4c4c4
hi StatusLineNC gui=NONE guifg=#707070 guibg=#c4c4c4
hi VertSplit    gui=NONE guifg=#707070 guibg=#c4c4c4
hi WildMenu     gui=NONE guifg=#000000 guibg=#ff80c0
hi WildMenu     ctermfg=075 ctermbg=235 cterm=none              gui=none        guifg=#5fafff       guibg=#262626

" Cursor
hi Cursor       ctermfg=234 ctermbg=250                         gui=None        guifg=#1c1c1c       guibg=#bcbcbc
hi CursorColumn ctermbg=235 cterm=none                          gui=None                            guibg=#8800ff
hi CursorLine   ctermbg=235 cterm=none                          gui=None        guifg=NONE          guibg=#2f4f4f
"hi CursorLine   ctermbg=235 cterm=none                          gui=None        guifg=NONE          guibg=#2e8b57

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
hi cCustomFunc                                                 gui=NONE        guifg=#87dfff
hi cCustomClass                                                gui=NONE        guifg=#87ffaf

