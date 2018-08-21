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

" codenize.tools
autocmd BufNewFile,BufRead *.iam set filetype=ruby
autocmd BufNewFile,BufRead *.elb set filetype=ruby
autocmd BufNewFile,BufRead *.route set filetype=ruby
autocmd BufNewFile,BufRead *.group set filetype=ruby

" To fix sh mode's syntax highlight for `$()`.
" https://www.reddit.com/r/vim/comments/25g1sp/why_doesnt_vim_syntax_like_my_shell_files/chlc4ep/
let g:is_posix = 1
