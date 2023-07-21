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
