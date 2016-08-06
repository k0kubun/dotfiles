#!/bin/zsh

# ロード
source csa.zsh
# またはデバッグモードでロード
#source =(sed 's/#DEBUG//' csa.zsh)

# 初期化
# csa_init を呼んだ後は普通の alias コマンドを使わないこと
csa_init

# コンテキストを更新する関数
function my_context_func {
	local -a ctx
	# Git リポジトリの中にいるなら git コンテキストを追加
	if [[ -n `git rev-parse --git-dir 2> /dev/null` ]]; then
		ctx+=git
	fi
	# Mercurial リポジトリの中にいるなら hg コンテキストを追加
	if [[ -n `hg root 2> /dev/null` ]]; then
		ctx+=hg
	fi
	if [[ -e Rakefile ]]; then
		ctx+=rake
	fi
	if [[ -e Gemfile ]]; then
		ctx+=bundler
	fi

	# コンテキストをセット
	# 同名のエイリアスが複数のコンテキストで定義されている場合、
	# 配列変数 ctx 内の*より後ろ*にあるコンテキストのエイリアスが優先される
	csa_set_context $ctx
}

# コンテキストを更新する関数が cd のたびに呼ばれるようにする
typeset -ga chpwd_functions
chpwd_functions+=my_context_func

# エイリアスを定義
csalias git st 'git status'
csalias hg st 'hg status'
csalias rake ra 'rake'
csalias bundler ra 'bundle exec rake'

# ↑カレントディレクトリに Rakefile と Gemfile が両方とも存在する場合、
# bundler コンテキストのエイリアスが優先される
# （my_context_func 内で rake コンテキストの*後*に bundler コンテキストを追加しているため）
