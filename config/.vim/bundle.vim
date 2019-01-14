set nocompatible
filetype plugin indent off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle'))
endif

" Language
NeoBundleLazy 'vim-ruby/vim-ruby', { 'autoload': { 'filetypes': 'ruby' } }
NeoBundle 'kana/vim-textobj-user'
NeoBundleLazy 'kana/vim-textobj-indent', { 'autoload': { 'filetypes': ['haml'] } } " `vii` to select block
NeoBundleLazy 'rhysd/vim-textobj-ruby', { 'autoload': { 'filetypes': 'ruby' } }
NeoBundleLazy 'mrkn/vim-cruby', { 'autoload': { 'filetypes': ['c', 'cruby'] } }
" NeoBundle 'tpope/vim-rails'
NeoBundleLazy 'tpope/vim-haml', { 'autoload': { 'filetypes': 'haml' } }
NeoBundleLazy 'slim-template/vim-slim', { 'autoload': { 'filetypes': 'slim' } }
NeoBundleLazy 'kchmck/vim-coffee-script', { 'autoload': { 'filetypes': ['coffee'] } }
NeoBundleLazy 'fatih/vim-go', { 'autoload': { 'filetypes': ['go'] } }
NeoBundleLazy 'vim-scripts/applescript.vim', { 'autoload': { 'filetypes': ['applescript'] } }
" NeoBundle 'Shougo/vinarise.vim'
" NeoBundleLazy 'rodjek/vim-puppet', { 'autoload': { 'filetypes': ['puppet'] } }
" NeoBundleLazy 'elixir-lang/vim-elixir', { 'autoload': { 'filetypes': ['elixir'] } }
NeoBundleLazy 'vim-jp/vim-cpp', { 'autoload': { 'filetypes': ['c', 'cpp'] } }
NeoBundleLazy 'othree/yajs.vim', { 'autoload': { 'filetypes': ['javascript'] } }
NeoBundleLazy 'othree/es.next.syntax.vim', { 'autoload': { 'filetypes': ['javascript'] } }
NeoBundleLazy 'gavocanov/vim-js-indent', { 'autoload': { 'filetypes': ['javascript'] } }
" NeoBundleLazy 'rust-lang/rust.vim', { 'autoload' : { 'filetypes': 'rust' } }
" NeoBundleLazy 'cespare/vim-toml', { 'autoload' : { 'filetypes': 'toml' } }
" NeoBundleLazy 'racer-rust/vim-racer', { 'autoload' : { 'filetypes': 'rust' } }
NeoBundleLazy 'Vimjas/vim-python-pep8-indent', { 'autoload': { 'filetypes': ['python'] } }
" if has("python")
"   NeoBundleLazy 'artur-shaik/vim-javacomplete2', { 'autoload': { 'filetypes': ['java'] } }
" endif

" Completion
if has("lua")
  NeoBundleLazy 'Shougo/neocomplete.vim', { 'autoload': { 'insert': 1 } }
endif

" Skin
NeoBundle 'w0ng/vim-hybrid'

" Editing
NeoBundleLazy 'bronson/vim-trailing-whitespace', { 'autoload': { 'commands': ['FixWhitespace'], "insert": 1 } }
NeoBundleLazy 'osyo-manga/vim-over', { 'autoload': { 'commands': ['OverCommandLine'] } }
NeoBundle 'vim-scripts/netrw.vim'
NeoBundleLazy 'tpope/vim-abolish', { 'autoload': { 'insert': 1 } }
if has('mac')
  NeoBundle 'tyru/skk.vim'
  NeoBundle 'tyru/skkdict.vim'
endif

" Unite
NeoBundleLazy 'Shougo/unite.vim', '76612ec', { 'autoload': { 'commands': ['Unite', 'UniteWithBufferDir'] } }
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
NeoBundleLazy 'airblade/vim-gitgutter', { 'autoload': { 'insert': 1 } }

NeoBundleCheck

filetype plugin indent on
