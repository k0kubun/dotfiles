# zsh prompt
PROMPT='%F{cyan}%(5~,%-2~/.../%2~,%~)%f $ '
autoload -Uz vcs_info
precmd() {
	psvar=()
	LANG=en_US.UTF-8 vcs_info
	psvar[1]="$vcs_info_msg_0_"
}
RPROMPT=" %1(v|%F{green}%1v%f|)"
