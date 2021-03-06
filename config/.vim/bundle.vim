if &compatible
  set nocompatible
endif

" mkdir -p ~/.config/vim/dein/repos/github.com/Shougo
" ln -s ~/.config/nvim/dein/repos/github.com/Shougo/dein.vim ~/.config/vim/dein/repos/github.com/Shougo/dein.vim
" ln -s ~/.config/nvim/dein.toml ~/.config/vim/dein.toml
" ln -s ~/.config/nvim/dein_lazy.toml ~/.config/vim/dein_lazy.toml
let s:nvim = '~/.config/vim/'
set runtimepath+=~/.config/vim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state(s:nvim . 'dein')
  call dein#begin(s:nvim . 'dein', [s:nvim . 'dein.toml', s:nvim . 'dein_lazy.toml'])
  call dein#load_toml(s:nvim . 'dein.toml')
  call dein#load_toml(s:nvim . 'dein_lazy.toml', {'lazy': 1})
  call dein#end()
  call dein#save_state()
  if dein#check_install()
    call dein#install()
  endif
endif

filetype plugin indent on
syntax enable
