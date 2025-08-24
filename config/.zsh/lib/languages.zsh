# Python
export PATH="$HOME/.pyenv/bin:$PATH"
# Disable pyenv because "pyenv init" is very slow
# if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# Scheme
alias gosh="gosh-rl"

# TeX
export PATH="$PATH:/usr/texbin"
function tex() {
	platex $1
	dvipdfmx $1
	rm *.dvi
	rm *.log
	rm *.aux
}

# Haskell
export PATH=$HOME/.cabal/bin:$PATH
alias ce="cabal exec"

# Rust
export PATH=$HOME/.cargo/bin:$PATH

# ruby-install
export RUBY_INSTALL_SRC_DIR="$HOME/.cache/ruby"
export RUBY_INSTALL_RUBIES_DIR=/opt/rubies
