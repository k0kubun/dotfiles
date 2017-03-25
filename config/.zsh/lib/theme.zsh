# zsh prompt
PROMPT='$ '
autoload -Uz vcs_info
precmd() {
	LANG=en_US.UTF-8 vcs_info
  local left="$(pwd)"
  local right="$vcs_info_msg_0_"
  echo -e "\e[36m${left}\e[m${(r:($COLUMNS-${#left}-${#right}):: :)}\e[32m${right}\e[m"
}
