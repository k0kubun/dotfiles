"===============================================================================
" Setup dein.vim
"===============================================================================
if &compatible
  set nocompatible
endif

let s:dein_cache = $HOME . '/.cache/dein'
let s:dein_path  = expand(s:dein_cache . '/repos/github.com/Shougo/dein.vim')
if !isdirectory(s:dein_path)
  execute '!git clone --depth=1 https://github.com/Shougo/dein.vim' s:dein_path
endif
let &runtimepath .= ',' . s:dein_path

if dein#load_state(s:dein_cache)
  call dein#begin(s:dein_cache)

  " Dein
  call dein#add('Shougo/dein.vim')
  call dein#add('haya14busa/dein-command.vim', { 'on_cmd': ['Dein'] })

  " Styles
  call dein#add('w0ng/vim-hybrid')

  " Git
  call dein#add('tpope/vim-fugitive')
  call dein#add('airblade/vim-gitgutter')

  " SKK
  call dein#add('tyru/eskk.vim', { 'on_if': 'has("mac") && !exists("g:vscode")' })

  " Language
  call dein#add('vim-ruby/vim-ruby', { 'on_ft': ['ruby'] })
  call dein#add('udalov/kotlin-vim', { 'on_ft': ['kotlin'] })
  call dein#add('cespare/vim-toml', { 'on_ft': ['toml'] })
  call dein#add('lervag/vimtex', { 'on_ft': ['tex'] }) " apt install latexmk
  call dein#add('leafgarland/typescript-vim', { 'on_ft': ['typescript', 'typescriptreact'] })
  call dein#add('peitalin/vim-jsx-typescript', { 'on_ft': ['typescriptreact'] })
  call dein#add('dart-lang/dart-vim-plugin', { 'on_ft': ['dart'] })

  " Editing
  call dein#add('neoclide/coc.nvim', { 'rev': 'release', 'on_i': 1 })
  call dein#add('osyo-manga/vim-over', { 'on_cmd': ['OverCommandLine'] })
  call dein#add('bronson/vim-trailing-whitespace', { 'on_cmd': ['FixWhitespace'] })
  call dein#add('Shougo/vinarise.vim', { 'on_cmd': ['Vinarise'] })
  call dein#add('junegunn/fzf', { 'on_cmd': ['call'] })

  " Git
  call dein#add('tyru/open-browser.vim', { 'hook_post_source': 'call SetupOpenBrowser()' })
  call dein#add('k0kubun/open-browser-github.vim', { 'on_cmd': ['OpenGithubFile'],
        \ 'depends': ['open-browser.vim'], 'hook_post_source': 'call SetupOpenBrowserGithub()' })

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable

if dein#tap('open-browser.vim')
  function! SetupOpenBrowser() abort
    delfunction OpenBrowser
    delcommand OpenBrowser
    delfunction OpenBrowserSearch
    delcommand OpenBrowserSearch
    delcommand OpenBrowserSmartSearch
  endfunction
endif

if dein#tap('open-browser-github.vim')
  let g:openbrowser_github_select_current_line = 1
  let g:openbrowser_github_url_exists_check = 'ignore'

  function! SetupOpenBrowserGithub() abort
    delcommand OpenGithubCommit
    delcommand OpenGithubIssue
    delcommand OpenGithubProject
    delcommand OpenGithubPullReq
  endfunction
endif

"===============================================================================
" Key binding
"===============================================================================
" End Vim
nnoremap <silent> ;xc :qa!<CR>
" Explore
nnoremap <silent> ;e :<C-u>Explore<CR>

" fzf
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'yoffset': 0.1 } }
function! s:my_fzf_files() abort
  let git_root = system('git rev-parse --show-toplevel 2>/dev/null')
  if git_root ==# ''
    call fzf#run(fzf#wrap({'source': 'find .', 'options': '--reverse --exact --no-sort'}))
  else
    call fzf#run(fzf#wrap({'source': 'git ls-files', 'options': '--reverse --exact --no-sort'}))
  endif
endfunction
nnoremap <silent> ;u :<C-u>call <SID>my_fzf_files()<CR>
set timeoutlen=1000 ttimeoutlen=0

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

" binding.irb
autocmd FileType ruby inoremap <buffer> <C-v> binding.irb
autocmd FileType python inoremap <C-v> import code; code.interact(local=dict(globals(), **locals()))

" coc
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-p> coc#pum#visible() ? coc#pum#prev(1) : "\<Nop>"
inoremap <silent><expr> <C-n> coc#pum#visible() ? coc#pum#next(1) : "\<Nop>"
nnoremap <silent> <M-@> <Plug>(coc-definition)
autocmd ColorScheme * highlight link CocMenuSel PmenuSel
let g:coc_global_extensions = [
\ 'coc-clangd',
\]

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

if dein#tap('eskk.vim')
  let g:eskk#large_dictionary = {'path': '~/Library/Application Support/AquaSKK/SKK-JISYO.L', 'sorted': 1, 'encoding': 'euc-jp'}
endif

if dein#tap('vimtex')
  let g:vimtex_matchparen_enabled = 0
endif

"===============================================================================
" Styles
"===============================================================================
colorscheme hybrid
hi Normal ctermbg=NONE

set number        " Show line number
set cmdheight=2   " 2-line command window
set showtabline=2 " Always show a tab line
set t_Co=256      " Allow 256 colors https://jonasjacek.github.io/colors
set guicursor=n-v-c-sm-i-ci-ve:block,r-cr-o:hor20 " Fix Neovim cursor

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
" Python (vinarise)
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
