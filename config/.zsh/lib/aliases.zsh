# .zshrc reload
alias re="source ~/.zshrc"

# vim
alias vim="nvim"
function vi() {
  nvim ${=*/:/ +}
}

# Prefer brew's vim
export PATH="/opt/brew/bin:/usr/local/bin:${PATH}"

# cd by dir name only for ..
alias ..="cd .."

# bundler
alias be="bundle exec"
