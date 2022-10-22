# Configuration for git
alias gs="git status"
alias gd="git --no-pager diff"
alias ga="git commit -am"
alias gh="git branch"
alias co="git checkout"
alias amend="git commit --amend"
alias empty="git commit --allow-empty -m"

alias current-branch='git rev-parse --abbrev-ref HEAD'

function gl(){
	if [ $# -ne 0 ]; then
		git --no-pager log --date=iso --no-show-signature --pretty=format:'%h %Cgreen%ad %Cblue%an %Creset%s %C(blue)%d%Creset' "$@"
	else
		git --no-pager log --date=iso --no-show-signature --pretty=format:'%h %Cgreen%ad %Cblue%an %Creset%s %C(blue)%d%Creset' -10
	fi
}

# git push to current branch with remote fallback
function gp() {
	if [ $# -ne 0 ]; then
		# check whether remote mine exists or not
		mine_push=false
		for arg in $@; do
			if [ $arg = "mine" ]; then
				mine_push=true
			fi
		done

		# if mine does not exist, push to origin
		if $mine_push; then
			if git remote | grep -q mine; then
				git push $@ `current-branch`
			else
				git push `echo $@ | sed -e "s/mine/origin/"` `current-branch`
			fi
		else
			git push $@ `current-branch`
		fi
	else
		git push
	fi
}

function gg() {
	if [[ -n `git rev-parse --git-dir 2> /dev/null` ]]; then
		git --no-pager grep -n $@
	else
		find . -type f | xargs grep -n --color=auto $@
	fi
}

function github-url() {
	ruby <<-EOS
		require 'uri'

		def parse_remote(remote_origin)
		  if remote_origin =~ /^(https|ssh):\/\//
		    uri = URI.parse(remote_origin)
		    [uri.host, uri.path]
		  elsif remote_origin =~ /^[^:\/]+:\/?[^:\/]+\/[^:\/]+$/
		    host, path = remote_origin.split(":")
		    [host.split("@").last, path]
		  else
		    raise "Not supported origin url: #{remote_origin}"
		  end
		end

		host, path = parse_remote(\`git config remote.origin.url\`.strip)
		puts "https://#{host}/#{path.gsub(/\.git$/, '')}"
	EOS
}

function preq() {
	# git rev-list --ancestry-path : only display commits that exist directly on the ancestry chain
	# git rev-list --first-parent  : follow only the first parent commit upon seeing a merge commit
	merge_commit=$(ruby -e 'print (File.readlines(ARGV[0]) & File.readlines(ARGV[1])).last' <(git rev-list --ancestry-path $1..master) <(git rev-list --first-parent $1..master))

	if git show $merge_commit | grep -q 'pull request'; then
		issue_number=$(git show $merge_commit | grep 'pull request' | ruby -ne 'puts $_.match(/#(\d+)/)[1]')
		url="$(github-url)/pull/${issue_number}"
	else
		url="$(github-url)/commit/${1}"
	fi

	if which open > /dev/null; then
		open $url
	else
		xdg-open $url
	fi
}
