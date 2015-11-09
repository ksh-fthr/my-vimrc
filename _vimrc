"*******************************************************
" neobundle を使ってプラグインを管理する
"*******************************************************

 " Note: Skip initialization for vim-tiny or vim-small.
 if 0 | endif

 if has('vim_starting')
   if &compatible
     set nocompatible               " Be iMproved
   endif

   " Required:
   set runtimepath+=C:/bin/vim74-kaoriya-win64/plugins/neobundle.vim

 endif

 " Required:
 call neobundle#begin(expand('C:/bin/vim74-kaoriya-win64/plugins'))


" 管理するプラグインを列挙
NeoBundleFetch 'https://github.com/flazz/vim-colorschemes.git'
NeoBundleFetch 'https://github.com/groenewege/vim-less.git'
NeoBundleFetch 'https://github.com/slim-template/vim-slim.git'
NeoBundleFetch 'https://github.com/w0ng/vim-hybrid.git'
NeoBundleFetch 'https://github.com/bcaccinolo/bclose.git'
NeoBundleFetch 'https://github.com/jpo/vim-railscasts-theme.git'
NeoBundleFetch 'https://github.com/corntrace/bufexplorer.git'
NeoBundleFetch 'https://github.com/kchmck/vim-coffee-script.git'
NeoBundleFetch 'https://github.com/fholgado/minibufexpl.vim.git'
NeoBundleFetch 'https://github.com/scrooloose/nerdtree.git'
NeoBundleFetch 'https://github.com/vim-scripts/ruby-matchit.git'
NeoBundleFetch 'https://github.com/vim-scripts/FuzzyFinder.git'
NeoBundleFetch 'https://github.com/vim-scripts/L9.git'
NeoBundleFetch 'https://github.com/vim-scripts/taglist.vim.git'
NeoBundleFetch 'https://github.com/tpope/vim-rails.git'
NeoBundleFetch 'https://github.com/tpope/vim-surround.git'
NeoBundleFetch 'https://github.com/tpope/vim-endwise.git'
NeoBundleFetch 'https://github.com/tpope/vim-bundler.git'
NeoBundleFetch 'https://github.com/Shougo/neocomplcache.git'
NeoBundleFetch 'https://github.com/Shougo/neosnippet.git'
NeoBundleFetch 'https://github.com/Shougo/neosnippet-snippets.git'
NeoBundleFetch 'https://github.com/Shougo/neocomplcache-rsense.git'
NeoBundleFetch 'https://github.com/Shougo/neobundle.vim'
NeoBundleFetch 'https://github.com/Shougo/neosnippet-snippets'
NeoBundleFetch 'https://github.com/Shougo/neocomplete.vim'
NeoBundleFetch 'https://github.com/Shougo/unite.vim'
NeoBundleFetch 'https://github.com/ksh-fthr/vim-throne.git'
NeoBundleFetch 'https://github.com/ksh-fthr/vim-zabanya.git'
NeoBundleFetch 'https://github.com/tyru/vim-altercmd'
NeoBundleFetch 'https://github.com/vim-scripts/bufkill.vim'
NeoBundleFetch "https://github.com/t9md/vim-quickhl"
NeoBundleFetch "https://github.com/tyru/caw.vim"
NeoBundleFetch "https://github.com/osyo-manga/vim-marching"
NeoBundleFetch 'hokorobi/vim-tagsgen' 
NeoBundleFetch 'scrooloose/syntastic.git'
NeoBundleFetch 'https://github.com/hokorobi/vim-tagsgen'
NeoBundleFetch 'https://github.com/jelera/vim-javascript-syntax'
NeoBundleFetch 'https://github.com/mattn/jscomplete-vim'
NeoBundleFetch 'https://github.com/majutsushi/tagbar'
NeoBundleFetch 'https://github.com/hail2u/vim-css3-syntax'
NeoBundleFetch 'https://github.com/nathanaelkane/vim-indent-guides'
NeoBundleFetch 'https://github.com/bronson/vim-trailing-whitespace'
NeoBundleFetch 'https://github.com/othree/html5.vim'
NeoBundleFetch 'https://github.com/Chiel92/vim-autoformat'

" ↓ Windows 非対応 ↓
"NeoBundleFetch 'soramugi/auto-ctags.vim'
"NeoBundleFetch 'szw/vim-tags'
" ↑ Windows 非対応 ↑


 call neobundle#end()

" Required:
 filetype plugin indent on

 " If there are uninstalled bundles found on startup,
 " this will conveniently prompt you to install them.
 NeoBundleCheck

