# monkey command extensions

function ghq() {
	super=$(which -a $0 | tail -n1)

	case $1 in
		get )
			repo=$2

			# always clone with ssh scheme
			$super get $repo -p

			# hook after ghq get
			silent-nohup ghq-cache update

			matched=`$super list | grep "${repo}$"`
			if [[ $matched != "" ]]; then
				repo_dir="${GOPATH}/src/${matched}"
				pushd $repo_dir > /dev/null
				private
				popd > /dev/null
			fi
			;;
		list )
			if [ ! -e ~/.ghq-cache ]; then
				ghq-cache update
			fi

			# use ghq list ordered by ghq-cache
			cat ~/.ghq-cache
			;;
		* )
			$super $@
			;;
	esac
}

function git() {
	super=$(which -a $0 | tail -n1)

	case $1 in
		init )
			$super $@
			silent-nohup ghq-cache update
			;;
		clone )
			$super $@
			silent-nohup ghq-cache update
			;;
		* )
			$super $@
			;;
	esac
}
