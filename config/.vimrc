"===============================================================================
" NeoVim config
"===============================================================================
source ~/.config/nvim/init.vim

"===============================================================================
" Bundle
"===============================================================================
" " Language
" NeoBundleLazy 'vim-ruby/vim-ruby', { 'autoload': { 'filetypes': 'ruby' } }
" NeoBundle 'kana/vim-textobj-user'
" NeoBundleLazy 'kana/vim-textobj-indent', { 'autoload': { 'filetypes': ['haml'] } } " `vii` to select block
" NeoBundleLazy 'rhysd/vim-textobj-ruby', { 'autoload': { 'filetypes': 'ruby' } }
" NeoBundleLazy 'mrkn/vim-cruby', { 'autoload': { 'filetypes': ['c', 'cruby'] } }
" " NeoBundle 'tpope/vim-rails'
" NeoBundleLazy 'tpope/vim-haml', { 'autoload': { 'filetypes': 'haml' } }
" NeoBundleLazy 'slim-template/vim-slim', { 'autoload': { 'filetypes': 'slim' } }
" NeoBundleLazy 'kchmck/vim-coffee-script', { 'autoload': { 'filetypes': ['coffee'] } }
" NeoBundleLazy 'fatih/vim-go', { 'autoload': { 'filetypes': ['go'] } }
" NeoBundleLazy 'vim-scripts/applescript.vim', { 'autoload': { 'filetypes': ['applescript'] } }
" NeoBundleLazy 'Shougo/vinarise.vim', { 'autoload': { 'commands': ['Vinarise'] } }
" " NeoBundleLazy 'rodjek/vim-puppet', { 'autoload': { 'filetypes': ['puppet'] } }
" " NeoBundleLazy 'elixir-lang/vim-elixir', { 'autoload': { 'filetypes': ['elixir'] } }
" NeoBundleLazy 'vim-jp/vim-cpp', { 'autoload': { 'filetypes': ['c', 'cpp'] } }
" NeoBundleLazy 'othree/yajs.vim', { 'autoload': { 'filetypes': ['javascript'] } }
" NeoBundleLazy 'othree/es.next.syntax.vim', { 'autoload': { 'filetypes': ['javascript'] } }
" NeoBundleLazy 'gavocanov/vim-js-indent', { 'autoload': { 'filetypes': ['javascript'] } }
" " NeoBundleLazy 'rust-lang/rust.vim', { 'autoload' : { 'filetypes': 'rust' } }
" " NeoBundleLazy 'racer-rust/vim-racer', { 'autoload' : { 'filetypes': 'rust' } }
" NeoBundleLazy 'Vimjas/vim-python-pep8-indent', { 'autoload': { 'filetypes': ['python'] } }
" NeoBundleLazy 'udalov/kotlin-vim', { 'autoload': { 'filetypes': ['kotlin'] } }
" " if has("python")
" "   NeoBundleLazy 'artur-shaik/vim-javacomplete2', { 'autoload': { 'filetypes': ['java'] } }
" " endif
" " NeoBundleLazy 'lcolaholicl/vim-v', { 'autoload': { 'filetypes': ['v'] } }
" NeoBundleLazy 'PProvost/vim-ps1', { 'autoload': { 'filetypes': ['ps1'] } }
" NeoBundleLazy 'leafgarland/typescript-vim', { 'autoload': { 'filetypes': ['typescript'] } }
" NeoBundleLazy 'motus/pig.vim', { 'autoload': { 'filetypes': ['pig'] } }

" NeoBundleLazy 'tpope/vim-abolish', { 'autoload': { 'insert': 1 } }

"===============================================================================
" Basic
"===============================================================================
" Basic Settings
set encoding=utf-8               " UTF-8
set browsedir=buffer             " Exploreの初期ディレクトリ
" set hidden                       " 編集中でも他のファイルを開けるようにする
set incsearch                    " インクリメンタル検索を行う
set showmatch                    " 対応するカッコを表示
" set cursorline                   " カレント行ハイライト（激しく重い）
set autoread                     " 更新時自動再読み込み
set hlsearch                     " 検索結果ハイライト
set laststatus=2                 " 常にステータスラインを表示
set bs=start,indent              " インサートモードで文字を消せるようにする

let loaded_matchparen = 1        " Don't highlight match parenthesis

" Well, backspace suddenly broke.
if has('mac')
  noremap! <C-?> <C-h>
endif

"===============================================================================
" Syntax
"===============================================================================
" Syntax highlights for custom extensions
autocmd BufNewFile,BufRead Gemfile set filetype=ruby
autocmd BufNewFile,BufRead Gemfile.shared set filetype=ruby
autocmd BufNewFile,BufRead *.cap set filetype=ruby
autocmd BufNewFile,BufRead *.schema set filetype=ruby
autocmd BufNewFile,BufRead *.god set filetype=ruby
autocmd BufNewFile,BufRead *file set filetype=ruby
autocmd BufNewFile,BufRead Makefile set filetype=make
autocmd BufNewFile,BufRead Dockerfile set filetype=dockerfile
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd BufNewFile,BufRead .itamae set filetype=yaml
autocmd BufNewFile,BufRead *.tex set filetype=tex
autocmd BufNewFile,BufRead *.yml.sample set filetype=yaml
autocmd BufNewFile,BufRead *.jelly set filetype=xml
autocmd BufNewFile,BufRead *.nas set filetype=asm
autocmd BufNewFile,BufRead *.img Vinarise
autocmd BufNewFile,BufRead *.applescript setl filetype=applescript
autocmd BufNewFile,BufRead default.conf setl filetype=apache
autocmd BufNewFile,BufRead rewrite.conf setl filetype=apache
autocmd BufNewFile,BufRead proxy.conf setl filetype=apache
autocmd BufNewFile,BufRead unicorn.conf setl filetype=ruby
autocmd BufNewFile,BufRead *.conf setl filetype=conf
autocmd BufNewFile,BufRead *.pp setl filetype=puppet
autocmd BufNewFile,BufRead xmobarrc setl filetype=haskell
autocmd BufNewFile,BufRead *.ex setl filetype=elixir
autocmd BufNewFile,BufRead *.c setl filetype=cpp
autocmd BufNewFile,BufRead *.scpt.erb set filetype=applescript
autocmd BufNewFile,BufRead .md2key set filetype=yaml
autocmd BufNewFile,BufRead *.al set filetype=ruby
autocmd BufNewFile,BufRead *.jb set filetype=ruby
autocmd BufNewFile,BufRead insns.def set filetype=cruby
autocmd BufNewFile,BufRead *.inc set filetype=cruby
autocmd BufNewFile,BufRead Makefile.inc set filetype=make
autocmd BufNewFile,BufRead *.v set filetype=v
autocmd BufNewFile,BufRead *.ps1 set filetype=ps1
autocmd BufNewFile,BufRead *.ts set filetype=typescript
autocmd BufNewFile,BufRead *.tmpl set filetype=c
autocmd BufNewFile,BufRead *.dig set filetype=yaml
autocmd BufNewFile,BufRead *.hql set filetype=sql

" codenize.tools
autocmd BufNewFile,BufRead *.iam set filetype=ruby
autocmd BufNewFile,BufRead *.elb set filetype=ruby
autocmd BufNewFile,BufRead *.route set filetype=ruby
autocmd BufNewFile,BufRead *.group set filetype=ruby

" binary editor
autocmd BufNewFile,BufRead *.class Vinarise
autocmd BufNewFile,BufRead *.o Vinarise
autocmd BufNewFile,BufRead *.o VinarisePluginDump
autocmd BufNewFile,BufRead *.so Vinarise
autocmd BufNewFile,BufRead *.so VinarisePluginDump

" To fix sh mode's syntax highlight for `$()`.
" https://www.reddit.com/r/vim/comments/25g1sp/why_doesnt_vim_syntax_like_my_shell_files/chlc4ep/
let g:is_posix = 1

"===============================================================================
" Indentation
"===============================================================================
set autoindent    " 自動でインデント
set smartindent   " 新しい行を開始したときに、新しい行のインデントを現在行と同じ量にする。
set cindent       " Cプログラムファイルの自動インデントを始める

if has("autocmd")
  autocmd FileType c          setlocal sw=4 sts=4 ts=4 et
  "autocmd FileType c          setlocal sw=2 sts=2 ts=2 et
  autocmd FileType cpp        setlocal sw=4 sts=4 ts=8 et
  autocmd FileType css        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType java       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType kotlin     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType groovy     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType javascript setlocal sw=2 sts=2 ts=2 et
  autocmd FileType ruby       setlocal sw=2 sts=2 ts=2 et iskeyword+=? " iskeyword+=!
  autocmd FileType haml       setlocal sw=2 sts=2 ts=2 et iskeyword+=? " iskeyword+=!
  autocmd FileType python     setlocal sw=4 sts=4 ts=4 list listchars=tab:»- " noet
  autocmd FileType slim       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType vim        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType haskell    setlocal sw=2 sts=2 ts=2 et
  autocmd FileType yacc       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType go         setlocal sw=4 sts=4 ts=4 et noexpandtab
  autocmd FileType zsh        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType sh         setlocal sw=2 sts=2 ts=2 et
  autocmd FileType asm        setlocal sw=4 sts=4 ts=4 et noexpandtab
  autocmd FileType make       setlocal ts=4 list listchars=tab:»-
  autocmd FileType cruby      setlocal list listchars=tab:»-

  autocmd BufNewFile,BufRead configure.ac setlocal ts=8 list listchars=tab:»-
endif

set cinoptions+=g1,h1

"===============================================================================
" Plugin
"===============================================================================
autocmd FileType python set completeopt-=preview

" Unite.vim
let g:unite_enable_start_insert = 1
let g:unite_source_file_mru_limit = 20
let g:unite_enable_auto_select = 0
" let g:unite_source_grep_command = 'ag'

" Unbind <C-e> in unite
augroup test
  autocmd!
  autocmd FileType unite inoremap <buffer> <C-e> <Esc>
augroup END

" disable trailing whitespace highlight in unite
"let g:extra_whitespace_ignored_filetypes = ['unite', 'cpp']
"let g:extra_whitespace_ignored_filetypes = ['unite', 'sql']

" Unite.vim redraw limit
" let g:unite_redraw_hold_candidates = 26000
let g:unite_redraw_hold_candidates = 70000

" vim-go
let g:go_gopls_enabled = 0
" let g:go_fmt_autosave = 1
" let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"

" let g:skk_jisyo = '~/vim-skk-jisyo.utf8'
if has('mac')
  let g:skk_large_jisyo = '~/Library/Application Support/AquaSKK/SKK-JISYO.L'
" elseif has('unix')
"   let g:skk_large_jisyo = '/usr/share/skk/SKK-JISYO.L'
endif

if has('mac')
  let g:skk_auto_save_jisyo = 1 " don't ask if save
  let g:skk_keep_state = 0
  let g:skk_kutouten_type = 'jp'
  let g:skk_egg_like_newline = 0
  let g:skk_show_annotation = 1
  let g:skk_use_face = 1
endif

" matchit.vim for ruby
source $VIMRUNTIME/macros/matchit.vim
augroup matchit
  au!
  au FileType ruby let b:match_words = '\<\(module\|class\|def\|begin\|do\|if\|unless\|case\)\>:\<\(elsif\|when\|rescue\)\>:\<\(else\|ensure\)\>:\<end\>'
augroup END

" sqlcomplete disable
let g:omni_sql_no_default_maps = 1

let g:openbrowser_github_select_current_line = 1

"===============================================================================
" Bind
"===============================================================================
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
" for n in range(1, 9)
"   execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
" endfor

" Hash Rocket
command! -bar -range=% NotRocket :<line1>,<line2>s/:\([a-z_]\+\)\s*=>/\1:/g
vnoremap <silent> gr :NotRocket<CR>

" Source .vimrc
noremap <silent> ;s :<C-u>source<Space>~/.vimrc<CR>

" windows new-window workaround
if has('win32unix')
  noremap <silent> <C-q> :<C-u>r !tmux new-window zsh<CR>
endif

" Golang
noremap <silent> ;t :!go test .<CR>
noremap <silent> ;r :!go run %<CR>

" break undo chain when using insert mode deletions (:h i_CTRL-G_u)
inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>

" pane size changer
nnoremap <C-w>> <C-w>14>
nnoremap <C-w>< <C-w>14<

" inoremap <C-v> begin;require "pry";binding.pry;rescue LoadError;require "irb";IRB.setup(nil);IRB.dbg(binding);end

" abbreviation
autocmd FileType java abbr psvm public static void main(String[] args) {<CR>}<Esc>O<BS><Space><Space><Space>

"===============================================================================
" Others
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
