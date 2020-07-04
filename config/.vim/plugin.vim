" neocomplete
if has("lua")
  " if_lua is required for neocomplete! Execute: `brew install vim --with-lua`"
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_auto_select = 1
  inoremap <expr><C-[> neocomplete#smart_close_popup()."\<Esc>"
  let g:neocomplete#sources#dictionary#dictionaries = {
  \   'ruby': $HOME . '/.vim/dicts/ruby.dict',
  \ }
endif

autocmd FileType python set completeopt-=preview

" Unite.vim
let g:unite_enable_start_insert = 1
let g:unite_source_file_mru_limit = 20
let g:unite_enable_auto_select = 0
let g:unite_source_grep_command = 'ag'

" Unbind <C-e> in unite
augroup test
  autocmd!
  autocmd FileType unite inoremap <buffer> <C-e> <Esc>
augroup END

" vim-tags
" let g:vim_tags_project_tags_command = "/usr/local/bin/ctags -R {OPTIONS} {DIRECTORY} 2>/dev/null"
" let g:vim_tags_gems_tags_command = "/usr/local/bin/ctags -R {OPTIONS} `bundle show --paths` 2>/dev/null"

" gocode
" set rtp+=$GOROOT/misc/vim
" let g:go_fmt_autofmt = 1

" golint
" exe "set rtp+=" . globpath($GOPATH, "src/github.com/golang/lint/misc/vim")

" disable trailing whitespace highlight in unite
let g:extra_whitespace_ignored_filetypes = ['unite']

" Unite.vim redraw limit
" let g:unite_redraw_hold_candidates = 26000
let g:unite_redraw_hold_candidates = 70000

" vim-go
let g:go_gopls_enabled = 0
" let g:go_fmt_autosave = 1
" let g:go_fmt_fail_silently = 1

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

" vim-javacomplete2
" if has("python")
"   autocmd FileType java setlocal omnifunc=javacomplete#Complete
"
"   let g:JavaComplete_ImportOrder = ['*']
"   let g:JavaComplete_ImportSortType = 'packageName'
"   let g:JavaComplete_RegularClasses = ['java.lang.String', 'java.lang.Object', 'java.lang.Class']
"   nmap [Tag]ja <Plug>(JavaComplete-Imports-AddMissing)
"   nmap [Tag]jr <Plug>(JavaComplete-Imports-RemoveUnused)
"   nmap [Tag]ji <Plug>(JavaComplete-Imports-AddSmart)
"   nmap [Tag]jI <Plug>(JavaComplete-Imports-Add)
" endif

" sqlcomplete disable
let g:omni_sql_no_default_maps = 1

" vim-gitgutter
highlight GitGutterAdd ctermfg=28
" highlight GitGutterAdd ctermfg=10 ctermbg=22
highlight GitGutterChange ctermfg=3
" highlight GitGutterChange ctermfg=11 ctermbg=58
if !has('mac')
  highlight GitGutterDelete ctermfg=9
  " highlight GitGutterDelete ctermfg=9 ctermbg=52
endif
let g:gitgutter_sign_removed = '-'
