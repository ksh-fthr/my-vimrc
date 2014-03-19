"*******************************************************
" neobundle を使ってプラグインを管理する
"*******************************************************
if has('vim_starting')
    set rtp+=$VIM/plugins/neobundle.vim
endif

" neobundle の初期化
call neobundle#rc(expand('$VIM/plugins'))

" 管理するプラグインを列挙
NeoBundle 'https://github.com/flazz/vim-colorschemes.git'
NeoBundle 'https://github.com/groenewege/vim-less.git'
NeoBundle 'https://github.com/slim-template/vim-slim.git'
NeoBundle 'https://github.com/w0ng/vim-hybrid.git'
NeoBundle 'https://github.com/bcaccinolo/bclose.git'
NeoBundle 'https://github.com/jpo/vim-railscasts-theme.git'
NeoBundle 'https://github.com/corntrace/bufexplorer.git'
NeoBundle 'https://github.com/kchmck/vim-coffee-script.git'
NeoBundle 'https://github.com/fholgado/minibufexpl.vim.git'
NeoBundle 'https://github.com/scrooloose/nerdtree.git'
NeoBundle 'https://github.com/vim-scripts/ruby-matchit.git'
NeoBundle 'https://github.com/vim-scripts/FuzzyFinder.git'
NeoBundle 'https://github.com/vim-scripts/L9.git'
NeoBundle 'https://github.com/vim-scripts/taglist.vim.git'
NeoBundle 'https://github.com/tpope/vim-rails.git'
NeoBundle 'https://github.com/tpope/vim-surround.git'
NeoBundle 'https://github.com/tpope/vim-endwise.git'
NeoBundle 'https://github.com/tpope/vim-bundler.git'
NeoBundle 'https://github.com/Shougo/neocomplcache.git'
NeoBundle 'https://github.com/Shougo/neosnippet.git'
NeoBundle 'https://github.com/Shougo/neocomplcache-rsense.git'
NeoBundle 'https://github.com/Shougo/neobundle.vim'
NeoBundle 'https://github.com/Shougo/neosnippet-snippets'
NeoBundle "https://github.com/Shougo/neocomplete.vim"
NeoBundle 'https://github.com/ksh-fthr/vim-throne.git'
NeoBundle 'https://github.com/ksh-fthr/vim-zabanya.git'
NeoBundle 'https://github.com/tyru/vim-altercmd'
NeoBundle 'https://github.com/vim-scripts/bufkill.vim'
NeoBundle "https://github.com/t9md/vim-quickhl"
NeoBundle "https://github.com/tyru/caw.vim"
NeoBundle "https://github.com/osyo-manga/vim-marching"

filetype plugin indent on


