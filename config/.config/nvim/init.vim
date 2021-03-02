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
" Denite
nnoremap <silent> ;u :<C-u>Denite -start-filter -winheight=18 -prompt=>
      \ `finddir('.git', ';') != '' ? 'file/rec/git' : 'file/rec'`<CR>
"autocmd FileType denite imap ;q denite#do_map('quit')
autocmd FileType denite call s:denite_binding()
function! s:denite_binding() abort
  nnoremap <silent><buffer><expr> <CR>      denite#do_map('do_action')
  " nnoremap <silent><buffer><expr> d       denite#do_map('do_action', 'delete')
  " nnoremap <silent><buffer><expr> p       denite#do_map('do_action', 'preview')
  " nnoremap <silent><buffer><expr> ;q        denite#do_map('quit')
  inoremap <silent><buffer><expr> ;q                                   denite#do_map('quit')
  " nnoremap <silent><buffer><expr> i       denite#do_map('open_filter_buffer')
  " nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'

  "call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
  "call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
endfunction
" autocmd BufLeave * silent! iunmap ;q

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
set clipboard& clipboard+=unnamed,unnamedplus " Copy to clipboard by yank

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
