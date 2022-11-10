function profile() {
  START_TIME=`~/bin/unixnano`
	source $1
  END_TIME=`~/bin/unixnano`

  TIME=`expr ${END_TIME} - ${START_TIME}`
  SEC=`expr $TIME / 1000000000`
  USEC=`expr $TIME % 1000000000`
  echo "${SEC}.`printf '%09d' $USEC`: $1"
}

bindkey -e

source ~/.zsh/lib/go.zsh
source ~/.zsh/lib/aliases.zsh
source ~/.zsh/lib/basic.zsh
source ~/.zsh/lib/completion.zsh
source ~/.zsh/lib/functions.zsh
source ~/.zsh/lib/git.zsh
source ~/.zsh/lib/languages.zsh
source ~/.zsh/lib/peco.zsh
source ~/.zsh/lib/theme.zsh

# Environment-local configurations
if [[ -f ~/.zshrc.`uname` ]]; then source ~/.zshrc.`uname`; fi
if [[ -f ~/.zshrc.local ]]; then source ~/.zshrc.local; fi

# Make scripts that want to put this line happy
# [[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)

# Enable syntax highlight: must be after all ZLE
if [[ ! -d ~/.zsh/bundle/zsh-syntax-highlighting ]]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/bundle/zsh-syntax-highlighting
fi
source ~/.zsh/bundle/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# https://jonasjacek.github.io/colors/
export TERM=xterm-256color

ZSH_HIGHLIGHT_STYLES[default]=fg=255
ZSH_HIGHLIGHT_STYLES[path]=fg=255
ZSH_HIGHLIGHT_STYLES[arg0]=fg=159
ZSH_HIGHLIGHT_STYLES[precommand]=fg=159
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=159

ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=186
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=186
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=186

ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=80
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=80
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=80

ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=80
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=80
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=80
