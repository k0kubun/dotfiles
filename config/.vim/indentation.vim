set autoindent    " 自動でインデント
set smartindent   " 新しい行を開始したときに、新しい行のインデントを現在行と同じ量にする。
set expandtab   " tabをspaceに置換しない
set cindent       " Cプログラムファイルの自動インデントを始める

set tabstop=2     " Tabの幅
set softtabstop=0 " Tabを押した時の幅(0だとtabstopと同じ)
set shiftwidth=2  " 自動インデントの各段階に使われる空白の数

if has("autocmd")
  filetype plugin on " ファイルタイプの検索を有効にする
  filetype indent on " ファイルタイプに合わせたインデントを利用

  autocmd FileType c          setlocal sw=4 sts=4 ts=4 et
  autocmd FileType cpp        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType css        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType java       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType groovy     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType javascript setlocal sw=2 sts=2 ts=2 et
  autocmd FileType ruby       setlocal sw=2 sts=2 ts=2 et iskeyword+=! iskeyword+=?
  autocmd FileType haml       setlocal sw=2 sts=2 ts=2 et iskeyword+=! iskeyword+=?
  autocmd FileType slim       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType vim        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType haskell    setlocal sw=2 sts=2 ts=2 et
  autocmd FileType yacc       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType go         setlocal sw=4 sts=4 ts=4 et noexpandtab
  autocmd FileType zsh        setlocal sw=2 sts=2 ts=2 et noexpandtab
  autocmd FileType sh         setlocal sw=2 sts=2 ts=2 et
  autocmd FileType asm        setlocal sw=4 sts=4 ts=4 et noexpandtab
  autocmd FileType make       setlocal ts=4 list listchars=tab:»-
  autocmd FileType cruby      setlocal list listchars=tab:»-
endif

set cinoptions+=g1,h1
