# .zshrc reload
alias re="source ~/.zshrc"

# vim
alias vim="vi"
function vi() {
  nvim ${=*/:/ +}
}

# cd by dir name only for ..
alias ..="cd .."

# bundler
alias be="bundle exec"

# tmux, inside agentx's sidebar when it's built. `td` detaches tmux, which also ends agentx.
AGENTX="$HOME/src/github.com/k0kubun/agentx/target/release/agentx"
function ta() {
  if [[ -n "$TMUX" || ! -x "$AGENTX" ]]; then
    tmux attach "$@"
  elif [[ $# -eq 0 ]]; then
    "$AGENTX"
  else
    "$AGENTX" -- tmux attach "$@"
  fi
}
alias td="tmux detach"
