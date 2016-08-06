vnoremap <buffer> zf :call <SID>fold_haskell()<CR>
function! s:fold_haskell() range
  let str = getline(a:firstline)
  if empty(str) || str =~# '\s$'
    call setline(a:firstline, str . '-- {{{')
  else
    call setline(a:firstline, str . ' -- {{{')
  endif

  let str = getline(a:lastline)
  if str =~# '^\s*$'
    call append(a:lastline-1, '-- }}}')
  elseif str =~# '\s$'
    call setline(a:lastline, str . '-- }}}')
  else
    call setline(a:lastline, str . ' -- }}}')
  endif
endfunction

setlocal omnifunc=necoghc#omnifunc
setlocal shiftwidth=4 softtabstop=4

nnoremap <buffer> mw :<C-u>UniteWithCursorWord hoogle<CR>
nnoremap <buffer> ms :<C-u>Unite -start-insert hoogle<CR>
