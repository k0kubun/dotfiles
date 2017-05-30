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
" augroup cruby
"   autocmd!
"   autocmd BufWinEnter,BufNewFile **/*.[chy] setlocal filetype=cruby
" augroup END
