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

source ~/.vim/syntax.vim
source ~/.vim/indentation.vim

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
