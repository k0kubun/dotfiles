# global aliases
alias -g B='`git branch | peco | sed -e "s/^\*[ ]*//g"`'
alias -g P='| peco | xargs '

if ! which peco > /dev/null; then
	return
fi

# history
function peco-select-history() {
	BUFFER=$(fc -l -r -n 1 | peco --query "$LBUFFER" --prompt "[zsh history]")
	CURSOR=$#BUFFER
	zle redisplay
}
zle -N peco-select-history
bindkey '^r' peco-select-history

function ghq-list() {
	if [[ $OPTIMIZE_GHQ_LIST = true ]]; then
		(cd ~/src; \ls -d github.com/*/* | sed 's/\/$//' | sort)
	else
		ghq list
	fi
}

# integrate all source code with ghq
function peco-src() {
	local selected_dir=$(ghq-list | peco --query "$LBUFFER" --prompt "[ghq list]")
	if [ -n "$selected_dir" ]; then
		full_dir="${GOPATH}/src/${selected_dir}"

		BUFFER="cd ${full_dir}"
		zle accept-line
	fi
	zle redisplay
}
zle -N peco-src
stty -ixon
bindkey '^s' peco-src

# process kill
function peco-pkill() {
	for pid in `ps aux | peco | awk '{ print $2 }'`
	do
		kill $pid
		echo "Killed ${pid}"
	done
}
alias pk="peco-pkill"

# search file recursively and append the path to the buffer
function peco-find-file() {
	if git rev-parse 2> /dev/null; then
		source_files=$(git ls-files)
	else
		source_files=$(find . -type f)
	fi
	selected_files=$(echo $source_files | peco --prompt "[find file]")

	BUFFER="${BUFFER}$(echo $selected_files | tr '\n' ' ')"
	CURSOR=$#BUFFER
	zle redisplay
}
zle -N peco-find-file
bindkey '^q' peco-find-file

# bundler directory
function bundler-directory() {
	bundle_show=`bundle show --paths`
	if [ $bundle_show = "Could not locate Gemfile" ]; then
		echo $bundle_show
		return
	fi
	dir=`echo ${bundle_show} | peco`
	if [ $? -eq 0 ]; then
		cd $dir
	fi
}
alias bd="bundler-directory"

# https://github.com/k0kubun/grimoire
alias grimoire-peco="grimoire | peco --initial-matcher=Regexp"

# fzf, actually for Vim
export FZF_DEFAULT_OPTS='--bind=ctrl-k:kill-line'
