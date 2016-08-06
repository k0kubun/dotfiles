#
# csa.zsh - Context-Sensitive Alias for Zsh
#

export CSA_CONTEXT
export CSA_PREV_CONTEXT
export CSA_ORIGINAL_ALIAS

typeset -A CSA_CTX2NAME
export CSA_CTX2NAME
typeset -A CSA_NAME2CMD
export CSA_NAME2CMD

#DEBUG function warn { print -P "%F{red}csa: $*%f" }

function csalias {
	local ctx=$1 name=$2 cmd=$3
	local names
	if [[ -z "$ctx" ]]; then
		for k in ${(k)CSA_CTX2NAME}; do
			echo $k:${CSA_CTX2NAME[$k]}
			#       ^ Note that the value is preceded by a space
		done
	elif [[ -z "$name" ]]; then
		names="${CSA_CTX2NAME[$ctx]} $name"
		for n in ${=names}; do
			echo "$ctx: $n='${CSA_NAME2CMD[$ctx.$n]}'"
		done
	else
		CSA_CTX2NAME[$ctx]="${CSA_CTX2NAME[$ctx]} $name"
		CSA_NAME2CMD[$ctx.$name]=$cmd
	fi
}

function csa_init {
	#DEBUG warn '-> csa_init'
	CSA_ORIGINAL_ALIAS=`alias`
}

function csa_set_context {
	#DEBUG warn '-> csa_set_context'
	CSA_PREV_CONTEXT=$CSA_CONTEXT
	CSA_CONTEXT=$*
	#DEBUG warn "curr ctx: $CSA_CONTEXT"
	#DEBUG warn "prev ctx: $CSA_PREV_CONTEXT"

	if [[ "x$CSA_CONTEXT" != "x$CSA_PREV_CONTEXT" ]]; then
		_csa_reset_alias
		_csa_set_alias_for_context default ${=CSA_CONTEXT}
	fi
}

function _csa_set_alias_for_context {
	#DEBUG warn '-> _csa_set_alias_for_context'
	local cmd ctx name names
	for ctx in $*; do
		names=${CSA_CTX2NAME[$ctx]}
		for name in ${=names}; do
			#DEBUG warn "($ctx) alias $name='${CSA_NAME2CMD[$ctx.$name]}'"
			cmd=${CSA_NAME2CMD[$ctx.$name]}
			alias $name=$cmd
		done
	done
}

function _csa_reset_alias {
	#DEBUG warn '-> _csa_reset_alias'
	local name2cmd
	local a as
	as=`alias`
	for a in ${(f)as}; do
		unalias ${a%%\=*}
	done
	for name2cmd in ${(f)CSA_ORIGINAL_ALIAS}; do
		eval "alias $name2cmd"
	done
}
