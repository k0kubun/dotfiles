"===============================================================================
" Setup dein.vim
"===============================================================================
if &compatible
  set nocompatible
endif

let s:nvim = '~/.config/nvim/'
set runtimepath+=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim

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

"===============================================================================
" Editing
"===============================================================================
set nowrap                                    " Don't wrap lines
set clipboard& clipboard+=unnamed,unnamedplus " Copy to clipboard by yank

"===============================================================================
" Key binding
"===============================================================================
" End Vim
nnoremap <silent> ;xc :qa!<CR>
" Explore
nnoremap <silent> ;e :<C-u>Explore<CR>

"===============================================================================
" Styles
"===============================================================================
colorscheme hybrid
hi Normal ctermbg=NONE

set number        " Show line number
set cmdheight=2   " 2-line command window
set showtabline=2 " Always show a tab line

"===============================================================================
" Tabline and statusline
"===============================================================================
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

function! s:my_tabline()
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction

let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'

set statusline=%{fugitive#statusline()}\ %<%f\ %=%{&fenc!=''?&fenc:&enc}\ %y\ %l/%L:%c\ %#Cursor#%#StatusLine#
