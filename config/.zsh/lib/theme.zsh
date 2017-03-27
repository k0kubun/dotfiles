autoload -Uz vcs_info

precmd() {
  local last_status="$?"
  LANG=en_US.UTF-8 vcs_info

  local left1="$(pwd) "
  local left2="status: $last_status"
  local right1="$vcs_info_msg_0_"

  psvar=()
  psvar[1]="${left1}"
  psvar[2]="${left2}"
  psvar[3]="${(r:($COLUMNS-${#left1}-${#left2}-${#right1}):: :)}"
  psvar[4]="${right1}"

  if [[ "x$last_status" == "x0" ]]; then
    PROMPT="%F{cyan}%1v%f%2v%3v%F{green}%4v%f
$ "
  else
    PROMPT="%F{cyan}%1v%f%F{red}%2v%f%3v%F{green}%4v%f
$ "
  fi
}
