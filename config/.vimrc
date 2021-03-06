"===============================================================================
" NeoVim config
"===============================================================================
source ~/.config/nvim/init.vim

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
" Others
"===============================================================================
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
