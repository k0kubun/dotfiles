" Setup dein.vim
if &compatible
  set nocompatible
endif

let s:nvim = '~/.config/nvim/'
set runtimepath+=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim
if !dein#load_state(s:nvim . 'dein')
  finish
endif
call dein#begin(s:nvim . 'dein', [s:nvim . 'dein.toml', s:nvim . 'dein_lazy.toml'])
call dein#load_toml(s:nvim . 'dein.toml')
call dein#load_toml(s:nvim . 'dein_lazy.toml', {'lazy': 1})
call dein#end()
call dein#save_state()

filetype plugin indent on
syntax enable
