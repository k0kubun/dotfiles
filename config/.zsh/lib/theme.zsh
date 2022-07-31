autoload -Uz vcs_info

if [[ $ZSH_SIMPLE_PROMPT = true ]]; then
  PROMPT="
$ "
  setopt noignore_eof
  return
fi

precmd() {
  local last_status="$?"
  LANG=en_US.UTF-8 vcs_info

  local left1="$(pwd) "
  local left2="[$(uname -m)] $(hostname | sed -e 's/\.local$//') "
  local left3="status: $last_status"
	local right1="$vcs_info_msg_0_"

  psvar=()
  psvar[1]="${left1}"
  psvar[2]="${left2}"
  psvar[3]="${left3}"
  psvar[4]="${(r:($COLUMNS-${#left1}-${#left2}-${#left3}-${#right1}):: :)}"
  psvar[5]="${right1}"

  if [[ "x$last_status" == "x0" ]]; then
    PROMPT="%F{cyan}%1v%f%F{blue}%2v%f%3v%4v%F{green}%5v%f
$ "
  else
    PROMPT="%F{cyan}%1v%f%F{blue}%2v%f%F{red}%3v%f%4v%F{green}%5v%f
$ "
	fi
}

"\$"() {
  export ZSH_SIMPLE_PROMPT=true
  $SHELL
}
