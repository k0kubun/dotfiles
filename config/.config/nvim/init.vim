"===============================================================================
" Setup dein.vim
"===============================================================================
if &compatible
  set nocompatible
endif

if has('nvim')
  let s:nvim = '~/.config/nvim/'
  set runtimepath+=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim
else
  let s:nvim = '~/.config/vim/'
  set runtimepath+=~/.config/vim/dein/repos/github.com/Shougo/dein.vim
endif

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
" Key binding
"===============================================================================
" End Vim
nnoremap <silent> ;xc :qa!<CR>
" Explore
nnoremap <silent> ;e :<C-u>Explore<CR>

" fzf-preview
function! s:my_fzf_files() abort
  let git_root = system('git rev-parse --show-toplevel 2>/dev/null')
  if git_root ==# ''
    FzfPreviewDirectoryFilesRpc --add-fzf-arg=--preview=''
    " CocCommand fzf-preview.DirectoryFiles
  else
    FzfPreviewProjectFilesRpc --add-fzf-arg=--preview=''
    " CocCommand fzf-preview.ProjectFiles
  endif
endfunction
nnoremap <silent> ;u :<C-u>call <SID>my_fzf_files()<CR>
let g:fzf_preview_direct_window_option = { 'width': 0.9, 'height': 0.6, 'relative': v:true, 'yoffset': 0.0 }

" Tabs
nnoremap <Plug>(tag)           <Nop>
nmap     <Space>               <Plug>(tag)
nnoremap <silent> <Plug>(tag)t <Cmd>tablast <bar> tabnew <bar> Explore<CR>
nnoremap <silent> <Plug>(tag)w <Cmd>tabclose<CR>
nnoremap <silent> <Plug>(tag)p <Cmd>tabnext<CR>
nnoremap <silent> <Plug>(tag)o <Cmd>tabprevious<CR>

" Delete highlight
nnoremap <silent> gh :let @/=''<CR>
" Git Blame
if exists("g:vscode")
  nnoremap <silent> gb :call VSCodeNotify('gitlens.toggleFileBlame')<CR>
  nnoremap <silent> gq :call VSCodeNotify('gitlens.toggleFileBlame')<CR>
else
  nnoremap <silent> gb :<C-u>Git blame<CR>
endif
" Paste
if has('mac')
  nnoremap gp :<C-u>r !pbpaste<CR>
elseif has('win32unix')
  nnoremap gp :<C-u>r !cat /dev/clipboard<CR>
else
  nnoremap gp :<C-u>r !xsel -b<CR>
endif

" Cursor in command line
cmap <C-f> <Right>
cmap <C-b> <Left>

" binding.pry
inoremap <C-v> binding.irb
autocmd FileType python inoremap <C-v> import code; code.interact(local=dict(globals(), **locals()))

" coc
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-p> coc#pum#visible() ? coc#pum#prev(1) : "\<Nop>"
inoremap <silent><expr> <C-n> coc#pum#visible() ? coc#pum#next(1) : "\<Nop>"
autocmd ColorScheme * highlight link CocMenuSel PmenuSel

"===============================================================================
" Indentation
"===============================================================================
set shiftwidth=2  " Indentation width
set softtabstop=0 " The number of spaces by Tab
set tabstop=2     " Hard tab width
set expandtab     " Indent with spaces

autocmd FileType asm    setlocal sw=4 sts=4 ts=4 et
autocmd FileType c      setlocal sw=4 sts=4 ts=8 et list listchars=tab:»-
autocmd FileType ruby   setlocal sw=2 sts=2 ts=2 et list listchars=tab:»-
autocmd FileType config setlocal sw=4 sts=4 ts=8 et list listchars=tab:»-
autocmd FileType cpp    setlocal sw=4 sts=4 ts=4 et
autocmd FileType go     setlocal sw=4 sts=4 ts=4 noet list listchars=tab:»-
autocmd FileType java   setlocal sw=4 sts=4 ts=4 et
autocmd FileType kotlin setlocal sw=4 sts=4 ts=4 et
autocmd FileType make   setlocal sw=4 sts=4 ts=4 noet list listchars=tab:»-
autocmd FileType proto  setlocal sw=4 sts=4 ts=4 et
autocmd FileType python setlocal sw=4 sts=4 ts=4 et list listchars=tab:»-
autocmd FileType vim    setlocal sw=2 sts=2 ts=2 et
autocmd FileType yaml   setlocal sw=2 sts=2 ts=2 et list listchars=tab:»-

"===============================================================================
" Syntax
"===============================================================================
autocmd BufNewFile,BufRead *.ipynb set filetype=json
autocmd BufNewFile,BufRead insns.def set filetype=c
autocmd BufNewFile,BufRead *.h set filetype=c

"===============================================================================
" Editing
"===============================================================================
set nowrap                                    " Don't wrap lines
set nofoldenable                              " Don't fold code comments in .vim
set noswapfile                                " Don't create .swp
set ignorecase                                " Case-insensitive search
set clipboard& clipboard+=unnamed,unnamedplus " Copy to clipboard by yank
let g:netrw_dirhistmax = 0                    " Prevent clipboard pollution
let loaded_matchparen = 1                     " Don't highlight a cursor on paren
autocmd FileType * set formatoptions-=ro      " Disable automatic comment out

" vim-trailing-whitespace
let g:extra_whitespace_ignored_filetypes = ['unite']

" SQLComplete:The dbext plugin must be loaded for dynamic SQL completion
let g:omni_sql_no_default_maps = 1

" I have no idea what I'm doing, but this seems to fix:
" https://github.com/neovim/neovim/issues/8906
set nomodeline

"===============================================================================
" Styles
"===============================================================================
colorscheme hybrid
hi Normal ctermbg=NONE

set number        " Show line number
set cmdheight=2   " 2-line command window
set showtabline=2 " Always show a tab line
set guicursor=    " Reset NeoVim cursor
set t_Co=256      " Allow 256 colors https://jonasjacek.github.io/colors

" vim-gitgutter
highlight GitGutterAdd ctermfg=28
highlight GitGutterChange ctermfg=3
highlight GitGutterDelete ctermfg=160
let g:gitgutter_sign_removed = '-'

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

"===============================================================================
" Python (coc, vinarise)
"===============================================================================
if has('mac')
  " brew install python
  " /usr/local/bin/pip3 install pynvim
  " :UpdateRemotePlugins
  let g:python3_host_prog = '/usr/local/bin/python3'
else
  let g:python3_host_prog = '/usr/bin/python3'
endif

"===============================================================================
" .vimrc.local
"===============================================================================
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
