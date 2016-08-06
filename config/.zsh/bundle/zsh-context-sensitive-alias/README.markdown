# Context-Sensitive Alias for Zsh

特定のコンテキストで有効になるエイリアスを定義できるスクリプトです。

使い方：

```
# {{{ in ~/.zshrc

# 初期化
source csa.zsh
csa_init
    
# コンテキストを指定してエイリアスを定義する
# csalias <context> <alias> <command>
csalias git st 'git status'
csalias hg st 'hg status'
csalias rake ra 'rake'
csalias bundler ra 'bundle exec rake'

# cd 先のリポジトリの種類に合わせてコンテキストを設定する（詳細は sample-zshrc.zsh で）
function chpwd() { ... }

# }}} 

# Git リポジトリに cd すると st == git status になる
$ cd git-repo
$ st
# On branch master
nothing to commit (working directory clean)

# Hg リポジトリに cd すると st == hg status になる
$ cd hg-repo
$ st
? readme.txt

# リポジトリでないディレクトリでは st は未定義
$ cd not-a-repo
$ st
zsh: command not found: st

# Rakefile があるディレクトリに cd すると ra == rake になる
$ cd some-ruby-lib
$ ra --version
rake, version 9.2.2

# Gemfile があるディレクトリに cd すると ra == bundle exec rake になる
# （同じディレクトリに Rakefile があっても ra == rake にはならない）
$ cd some-rails-proj
$ ra --version
rake, version 9.1.0
```

設定方法については `sample-zshrc.zsh` をご覧ください。
