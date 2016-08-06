set nocompatible
filetype plugin indent off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle'))
endif

" Language
NeoBundleLazy 'vim-ruby/vim-ruby', { 'autoload': { 'filetypes': 'ruby' } }
NeoBundleLazy 'mrkn/vim-cruby', { 'autoload': { 'filetypes': 'c' } }
" NeoBundle 'tpope/vim-rails'
NeoBundleLazy 'tpope/vim-haml', { 'autoload': { 'filetypes': 'haml' } }
NeoBundleLazy 'slim-template/vim-slim', { 'autoload': { 'filetypes': 'slim' } }
" NeoBundle 'plasticboy/vim-markdown'
NeoBundleLazy 'kchmck/vim-coffee-script', { 'autoload': { 'filetypes': ['coffee'] } }
" NeoBundle 'groenewege/vim-less'
" NeoBundle 'vim-scripts/coq-syntax'
" NeoBundle 'eagletmt/coqtop-vim'
" NeoBundle 'haruyama/scheme.vim'
NeoBundleLazy 'fatih/vim-go', { 'autoload': { 'filetypes': ['go'] } }
" NeoBundle 'vim-jp/vim-go-extra'
" NeoBundleLazy 'Blackrush/vim-gocode', {"autoload": {"filetypes": ['go']}}
" NeoBundle 'wannesm/wmnusmv.vim'
" NeoBundleLazy 'shinka-cb/smv_vim', {'autoload':{'filetypes':['smv']}}
" NeoBundle 'datsuns/vim-smv'
NeoBundleLazy 'vim-scripts/applescript.vim', { 'autoload': { 'filetypes': ['applescript'] } }
" NeoBundle 'aklt/plantuml-syntax'
" NeoBundle 'pbrisbin/vim-syntax-shakespeare'
" NeoBundle 'mustache/vim-mustache-handlebars'
" NeoBundle 'eagletmt/neco-ghc'
" NeoBundle 'eagletmt/ghcmod-vim'
" NeoBundle 'itchyny/vim-haskell-indent'
" NeoBundle 'Shougo/vinarise.vim'
NeoBundleLazy 'rodjek/vim-puppet', { 'autoload': { 'filetypes': ['puppet'] } }
NeoBundleLazy 'elixir-lang/vim-elixir', { 'autoload': { 'filetypes': ['elixir'] } }
NeoBundleLazy 'vim-jp/vim-cpp', { 'autoload': { 'filetypes': ['c', 'cpp'] } }
NeoBundleLazy 'othree/yajs.vim', { 'autoload': { 'filetypes': ['javascript'] } }
NeoBundleLazy 'othree/es.next.syntax.vim', { 'autoload': { 'filetypes': ['javascript'] } }
NeoBundleLazy 'gavocanov/vim-js-indent', { 'autoload': { 'filetypes': ['javascript'] } }

" Completion
" NeoBundle 'Shougo/neocomplcache.vim'
NeoBundleLazy 'Shougo/neocomplete.vim', { 'autoload': { 'insert': 1 } }

" Skin
" NeoBundle 'Lokaltog/powerline', 'da6667b', { 'rtp' : 'powerline/bindings/vim' } " too slow to load
" NeoBundle 'bling/vim-airline'
NeoBundle 'w0ng/vim-hybrid'

" Editing
NeoBundleLazy 'bronson/vim-trailing-whitespace', { 'autoload': { 'commands': ['FixWhitespace'], "insert": 1 } }
NeoBundleLazy 'osyo-manga/vim-over', { 'autoload': { 'commands': ['OverCommandLine'] } }
" NeoBundle 'thinca/vim-prettyprint'
" NeoBundle 'haya14busa/incsearch.vim'
" NeoBundle 'jeetsukumaran/vim-indentwise'
NeoBundle 'tyru/skk.vim'
" NeoBundle 'tyru/skkdict.vim'
NeoBundle 'vim-scripts/netrw.vim'
NeoBundleLazy 'tpope/vim-abolish', { 'autoload': { 'insert': 1 } }

" ctags
" NeoBundle 'szw/vim-tags'

" Unite
NeoBundleLazy 'Shougo/unite.vim', '76612ec', { 'autoload': { 'commands': ['Unite', 'UniteWithBufferDir'] } }
" NeoBundle 'yuku-t/unite-git'
NeoBundleLazy 'k0kubun/unite-git-files', { 'depends': 'Shougo/unite.vim', 'autoload': { 'unite_sources': ['git_files'] } }
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

" Git
NeoBundle 'tpope/vim-fugitive'
NeoBundleLazy 'k0kubun/vim-open-github', { 'autoload': { 'commands': ['OpenGithub'] } }
" NeoBundle 'gregsexton/gitv'
NeoBundleLazy 'airblade/vim-gitgutter', { 'autoload': { 'insert': 1 } }

NeoBundleCheck

filetype plugin indent on
