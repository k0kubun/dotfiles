if exists('b:did_indent')
  finish
endif

setlocal nocindent
setlocal nolisp
setlocal autoindent
setlocal indentexpr=GetSchemeIndent()
setlocal indentkeys=0{,0},0),0],!^F,o,O,e,:,.

setlocal expandtab
setlocal tabstop<
setlocal softtabstop=2
setlocal shiftwidth=2

let b:undo_indent = 'setlocal '.join([
\   'nocindent<',
\   'nolisp<',
\   'autoindent<',
\   'expandtab<',
\   'indentexpr<',
\   'indentkeys<',
\   'shiftwidth<',
\   'softtabstop<',
\   'tabstop<',
\ ])

function! GetSchemeIndent()
  let indentDiff = 0
  for i in range(1, v:lnum)
    let line = getline(i)
    let indentDiff += GetCharCount(line, "(")
    let indentDiff -= GetCharCount(line, ")")
  endfor

  return indentDiff * &l:shiftwidth
endfunction

function! GetCharCount(text, char)
  let cnt = 0
  for i in range(0, strlen(a:text) - 1)
    if a:text[i] == a:char
      let cnt += 1
    endif
  endfor
  return cnt
endfunction

let b:did_indent = 1
