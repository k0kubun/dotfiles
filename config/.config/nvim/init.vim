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
  call dein#add('petertriho/nvim-scrollbar')

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
  call dein#add('neoclide/jsonc.vim', { 'on_ft': ['jsonc'] })

  " LSP
  "call dein#add('neoclide/coc.nvim', { 'rev': 'release', 'on_i': 1 })
  call dein#add('neovim/nvim-lspconfig')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('deoplete-plugins/deoplete-lsp')

  " Editing
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

" coc
if dein#tap('coc.nvim')
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
  inoremap <silent><expr> <C-p> coc#pum#visible() ? coc#pum#prev(1) : "\<Nop>"
  inoremap <silent><expr> <C-n> coc#pum#visible() ? coc#pum#next(1) : "\<Nop>"
  "nnoremap <silent> <M-@> <Plug>(coc-definition)
  nnoremap <silent> <M-@> :<C-u>call CocAction('jumpDefinition', 'tabe')<CR>
  autocmd ColorScheme * highlight link CocMenuSel PmenuSel
  let g:coc_global_extensions = [
  \ 'coc-clangd',
  \ 'coc-rust-analyzer',
  \]
endif

if dein#tap('deoplete.nvim')
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#lsp#handler_enabled = v:true
  set completeopt+=noinsert
  call deoplete#custom#source('_', 'matchers', ['matcher_fuzzy', 'matcher_length'])
  call deoplete#custom#source('_', 'max_candidates', 10)
endif

if dein#tap('nvim-lspconfig')
  lua << END
  local fn = vim.fn
  local api = vim.api

  local M = {}

  -- possible values are 'arrow' | 'rounded' | 'blank'
  local active_sep = 'blank'

  -- change them if you want to different separator
  M.separators = {
    arrow = { '', '' },
    rounded = { '', '' },
    blank = { '', '' },
  }

  -- highlight groups
  M.colors = {
    active        = '%#StatusLine#',
    inactive      = '%#StatuslineNC#',
    mode          = '%#Mode#',
    mode_alt      = '%#ModeAlt#',
    git           = '%#Git#',
    git_alt       = '%#GitAlt#',
    filetype      = '%#Filetype#',
    filetype_alt  = '%#FiletypeAlt#',
    line_col      = '%#LineCol#',
    line_col_alt  = '%#LineColAlt#',
  }

  M.trunc_width = setmetatable({
    mode       = 80,
    git_status = 90,
    filename   = 140,
    line_col   = 60,
  }, {
    __index = function()
        return 80
    end
  })

  M.is_truncated = function(_, width)
    local current_width = api.nvim_win_get_width(0)
    return current_width < width
  end

  M.modes = setmetatable({
    ['n']  = {'Normal', 'N'};
    ['no'] = {'N·Pending', 'N·P'} ;
    ['v']  = {'Visual', 'V' };
    ['V']  = {'V·Line', 'V·L' };
    [''] = {'V·Block', 'V·B'}; -- this is not ^V, but it's , they're different
    ['s']  = {'Select', 'S'};
    ['S']  = {'S·Line', 'S·L'};
    [''] = {'S·Block', 'S·B'}; -- same with this one, it's not ^S but it's 
    ['i']  = {'Insert', 'I'};
    ['ic'] = {'Insert', 'I'};
    ['R']  = {'Replace', 'R'};
    ['Rv'] = {'V·Replace', 'V·R'};
    ['c']  = {'Command', 'C'};
    ['cv'] = {'Vim·Ex ', 'V·E'};
    ['ce'] = {'Ex ', 'E'};
    ['r']  = {'Prompt ', 'P'};
    ['rm'] = {'More ', 'M'};
    ['r?'] = {'Confirm ', 'C'};
    ['!']  = {'Shell ', 'S'};
    ['t']  = {'Terminal ', 'T'};
  }, {
    __index = function()
        return {'Unknown', 'U'} -- handle edge cases
    end
  })

  M.get_current_mode = function(self)
    local current_mode = api.nvim_get_mode().mode

    if self:is_truncated(self.trunc_width.mode) then
      return string.format(' %s ', self.modes[current_mode][2]):upper()
    end
    return string.format(' %s ', self.modes[current_mode][1]):upper()
  end

  M.get_git_status = function(self)
    -- use fallback because it doesn't set this variable on the initial `BufEnter`
    local signs = vim.b.gitsigns_status_dict or {head = '', added = 0, changed = 0, removed = 0}
    local is_head_empty = signs.head ~= ''

    if self:is_truncated(self.trunc_width.git_status) then
      return is_head_empty and string.format('  %s ', signs.head or '') or ''
    end

    return is_head_empty and string.format(
      ' +%s ~%s -%s |  %s ',
      signs.added, signs.changed, signs.removed, signs.head
    ) or ''
  end

  M.get_filename = function(self)
    if self:is_truncated(self.trunc_width.filename) then return " %<%f " end
    return " %<%F "
  end

  --M.get_filetype = function()
  --  local file_name, file_ext = fn.expand("%:t"), fn.expand("%:e")
  --  local icon = require'nvim-web-devicons'.get_icon(file_name, file_ext, { default = true })
  --  local filetype = vim.bo.filetype

  --  if filetype == '' then return '' end
  --  return string.format(' %s %s ', icon, filetype):lower()
  --end

  M.get_line_col = function(self)
    if self:is_truncated(self.trunc_width.line_col) then return ' %l:%c ' end
    return ' Ln %l, Col %c '
  end


  M.set_active = function(self)
    local colors = self.colors

    local mode = colors.mode .. self:get_current_mode()
    local mode_alt = colors.mode_alt .. self.separators[active_sep][1]
    local git = colors.git .. self:get_git_status()
    local git_alt = colors.git_alt .. self.separators[active_sep][1]
    local filename = colors.inactive .. self:get_filename()
    local filetype_alt = colors.filetype_alt .. self.separators[active_sep][2]
    --local filetype = colors.filetype .. self:get_filetype()
    local line_col = colors.line_col .. self:get_line_col()
    local line_col_alt = colors.line_col_alt .. self.separators[active_sep][2]

    return table.concat({
      colors.active, mode, mode_alt, git, git_alt,
      "%=", filename, "%=",
      filetype_alt,
      --filetype,
      line_col_alt, line_col
    })
  end

  M.set_inactive = function(self)
    return self.colors.inactive .. '%= %F %='
  end

  M.set_explorer = function(self)
    local title = self.colors.mode .. '   '
    local title_alt = self.colors.mode_alt .. self.separators[active_sep][2]

    return table.concat({ self.colors.active, title, title_alt })
  end

  Statusline = setmetatable(M, {
    __call = function(statusline, mode)
      if mode == "active" then return statusline:set_active() end
      if mode == "inactive" then return statusline:set_inactive() end
      if mode == "explorer" then return statusline:set_explorer() end
    end
  })

  -- set statusline
  -- TODO: replace this once we can define autocmd using lua
  api.nvim_exec([[
    augroup Statusline
    au!
    au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline('active')
    au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline('inactive')
    au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline('explorer')
    augroup END
  ]], false)

  vim.diagnostic.config({
    virtual_text = false,
    update_in_insert = true,
  })
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
        scope = 'cursor',
      }
      vim.diagnostic.open_float(nil, opts)
    end
  })

  local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', '<M-@>', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
  end

  local lspconfig = require'lspconfig'
  lspconfig.solargraph.setup({ on_attach = on_attach })
  --lspconfig.syntax_tree.setup({ on_attach = on_attach })
END
endif

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
autocmd BufNewFile,BufRead settings.json set filetype=jsonc
autocmd BufNewFile,BufRead keybindings.json set filetype=jsonc
autocmd BufNewFile,BufRead coc-settings.json set filetype=jsonc

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
set guicursor=n-v-c-sm-i-ci-ve-r-cr-o:block " Fix Neovim cursor

" vim-gitgutter
highlight GitGutterAdd ctermfg=28
highlight GitGutterChange ctermfg=3
highlight GitGutterDelete ctermfg=160
let g:gitgutter_sign_removed = '-'

"===============================================================================
" tabline, statusline, scrollbar
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

function! s:my_statusline()
  let s = '%{fugitive#statusline()} %<%f'
  if exists('coc#status') && len(coc#status()) > 0
    let s .= ' | %{coc#status()}'
  endif
  let s .= '%= %y %l/%L:%c %#Cursor#%#StatusLine#'
  return s
endfunction
let &statusline = '%!'. s:SID_PREFIX() . 'my_statusline()'

lua << END
require("scrollbar").setup({
  marks = {
    Error = {
      text = { "-" },
      priority = 1,
      cterm = 160,
    },
    Warn = {
      text = { "-" },
      priority = 2,
      cterm = 3,
    },
    Info = {
      text = { "o" },
      priority = 3,
      cterm = 3,
    },
    Hint = {
      text = { "-" },
      priority = 4,
      cterm = 252,
    },
    Misc = {
      text = { "?" },
      priority = 5,
      cterm = 3,
    },
  },
})
END

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
