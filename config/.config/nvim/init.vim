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
" Python support for denite.vim
"===============================================================================
let g:python3_host_prog = '/usr/bin/python3'

"===============================================================================
" Key binding
"===============================================================================
" End Vim
nnoremap <silent> ;xc :qa!<CR>
" Explore
nnoremap <silent> ;e :<C-u>Explore<CR>
" Unite
nnoremap <silent> ;u :<C-u>Unite -prompt=>\  -start-insert -silent -ignorecase
      \ buffer `finddir('.git', ';') != '' ? 'file_rec/git' : 'file_rec'`<CR>
autocmd FileType unite imap ;q <C-u><C-h>
autocmd BufLeave * silent! iunmap ;q

" Tabline
nnoremap [Tag] <Nop>
nmap <Space> [Tag]
map <silent> [Tag]t :tablast <bar> tabnew <bar> Explore <bar> vs<CR>
map <silent> [Tag]w :tabclose<CR>
map <silent> [Tag]p :tabnext<CR>
map <silent> [Tag]o :tabprevious<CR>

" Delete highlight
nnoremap <silent> gh :let @/=''<CR>
" Git Blame
nnoremap <silent> gb :<C-u>Gblame<CR>
" Paste
if has('mac')
  nnoremap gp :<C-u>r !pbpaste<CR>
elseif has('win32unix')
  nnoremap gp :<C-u>r !cat /dev/clipboard<CR>
else
  nnoremap gp :<C-u>r !xsel -b<CR>
endif

" binding.pry
inoremap <C-v> require "pry";binding.pry

"===============================================================================
" Editing
"===============================================================================
set nowrap                                    " Don't wrap lines
set nofoldenable                              " Ignore code folding comments
set clipboard& clipboard+=unnamed,unnamedplus " Copy to clipboard by yank
let g:netrw_dirhistmax = 0                    " Prevent clipboard pollution

"===============================================================================
" Styles
"===============================================================================
colorscheme hybrid
hi Normal ctermbg=NONE

set number               " Show line number
set cmdheight=2          " 2-line command window
set showtabline=2        " Always show a tab line
set guicursor=a:blinkon0 " Disable nvim's cursor changes, and disable blink

"===============================================================================
" Tabline and statusline
"===============================================================================
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

function! s:my_tabline()
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnr = tabpagebuflist(i)[tabpagewinnr(i) - 1]                          " First window appears first
    let s .= '%'.i.'T' . '%#'.(i == tabpagenr() ? 'TabLineSel' : 'TabLine').'#' " TabLineSel | TabLine
    let s .= i . ':[' . fnamemodify(bufname(bufnr), ':t') . ']'                 " i:[title]
    let s .= getbufvar(bufnr, '&modified') ? '!' : ' '                          " !
    let s .= '%#TabLineFill# '
  endfor
  return s . '%#TabLineFill#%T%=%#TabLine#'
endfunction

let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'

set statusline=%{fugitive#statusline()}\ %<%f\ %=%{&fenc!=''?&fenc:&enc}\ %y\ %l/%L:%c\ %#Cursor#%#StatusLine#
