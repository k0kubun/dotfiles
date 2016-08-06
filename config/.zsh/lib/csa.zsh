# zsh-context-sensitive-alias
source ~/.zsh/bundle/zsh-context-sensitive-alias/csa.zsh
csa_init
function my_context_func {
	local -a ctx
	if [[ -e Gemfile ]]; then
		ctx+=bundler
	fi
	csa_set_context $ctx
}
typeset -ga chpwd_functions
chpwd_functions+=my_context_func

# bundle exec auto alias
csalias bundler rails 'bundle exec rails'
csalias bundler rake 'bundle exec rake'
csalias bundler rspec 'bundle exec rspec'
csalias bundler cap 'bundle exec cap'
