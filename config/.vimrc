source ~/.vim/bundle.vim

source ~/.vim/basic.vim
source ~/.vim/syntax.vim
source ~/.vim/indentation.vim

source ~/.vim/skin.vim
source ~/.vim/plugin.vim
source ~/.vim/bind.vim

augroup vimrc-local
  autocmd!
  autocmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
augroup END

function! s:vimrc_local(loc)
  let files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction

" .vimrc.local template
" set shiftwidth=4  " Indent size automatically inserted by vim
" set softtabstop=0 " Indent size by pushing <Tab>, same as tabstop by 0
" set tabstop=8     " <Tab> width in screen
" set noexpandtab   " Don't replace tab with space
