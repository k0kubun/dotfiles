# tmux
export PATH="$HOME/bin:$PATH"
alias tmux="tmux -2"
if [[ -z "$TMUX" && -z "$STY" && "$TERM_PROGRAM" != "vscode" ]]; then
  if [[ -z "$SSH_TTY" ]]; then
    # Start tmux by default if not on SSH
    if type tmux > /dev/null 2>&1; then
      tmux new-session -A -s "*scratch*"
    fi
  fi
fi

function create-session() {
	if [ $# -ne 0 ]; then
		target_dir=$1
	else
		target_dir='.'
	fi
	target_dir=$(cd $target_dir; pwd)
	session_name=$(echo $target_dir | grep -o "[^/]*/[^/]*$" | sed -e "s/\./_/g")

	# switch or create session
	if tmux has-session -t $session_name > /dev/null 2>&1; then
		tmux switch-client -t $session_name
		return
	fi
	TMUX= tmux new-session -d -s $session_name -c $target_dir -n editor
	tmux switch-client -t $session_name

	# I usually work on 4 windows
	tmux send-keys -t $session_name "tmux new-window -d" C-m
	tmux send-keys -t $session_name "tmux new-window -d" C-m
	tmux send-keys -t $session_name "tmux new-window -d" C-m

	tmux send-keys -t $session_name "clear" C-m
	# tmux send-keys -t $session_name "tmux send-keys -t editor 'vi .' C-m" C-m
	# tmux send-keys -t $session_name "tmux send-keys -t editor ':vs' C-m" C-m
}
alias cs="create-session"
