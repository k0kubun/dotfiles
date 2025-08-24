# language
#export LANG=ja_JP.UTF-8

# auto cd by dir name
# setopt auto_cd

# auto pushd
setopt auto_pushd
setopt pushd_ignore_dups

# share zsh history
setopt share_history
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=10000000
export SAVEHIST=60000000

# don't logout by EOF
setopt ignore_eof

export PATH="/opt/local/bin:$PATH"
# export EDITOR="vim"

# El Capitan
export CPATH=/usr/local/opt/openssl/include:$CPATH

# Enable comments
#setopt interactivecomments
