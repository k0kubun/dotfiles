alias co="git checkout"
alias ga="git commit -am"
alias gd="git diff"
alias gh="git branch"
alias gs="git status"
function gl(){
	if [ $# -ne 0 ]; then
		git --no-pager log --date=iso --no-show-signature --pretty=format:'%h %Cgreen%ad %Cblue%an %Creset%s %C(blue)%d%Creset' "$@"
	else
		git --no-pager log --date=iso --no-show-signature --pretty=format:'%h %Cgreen%ad %Cblue%an %Creset%s %C(blue)%d%Creset' -10
	fi
}
alias amend="git commit --amend"
alias empty="git commit --allow-empty -m"

source /etc/zsh/zshrc.default.inc.zsh

# Override the ls of zshrc.default.inc.zsh
alias ls="ls --color --classify -la"
