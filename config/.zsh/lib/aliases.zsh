# override system ctags
# alias ctags="/usr/local/bin/ctags"

# .zshrc reload
alias re="source ~/.zshrc"

# vim
function vi() {
	vim ${=*/:/ +}
}

# Prefer brew's vim
export PATH="/opt/brew/bin:/usr/local/bin:${PATH}"

# cd by dir name only for ..
alias ..="cd .."

# Short hand for karabiner gem
alias dsl='karabiner dsl'
