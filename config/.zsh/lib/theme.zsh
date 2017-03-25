# zsh prompt
PROMPT='$ '
autoload -Uz vcs_info
precmd() {
  local last_status="$?"
  LANG=en_US.UTF-8 vcs_info

  local left1="$(pwd) "
  local left2="status: $last_status"
  local right1="$vcs_info_msg_0_"

  local left1c="\e[36m${left1}\e[m"
  if [[ "x$last_status" == "x0" ]]; then
    local left2c="${left2}"
  else
    local left2c="\e[31m${left2}\e[m"
  fi
  local right1c="\e[32m${right1}\e[m"

  echo -e "${left1c}${left2c}${(r:($COLUMNS-${#left1}-${#left2}-${#right1}):: :)}${right1c}"
}
