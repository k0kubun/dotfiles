include_role 'base'

include_cookbook 'git'
include_cookbook 'vim'
include_cookbook 'zsh'
include_cookbook 'ghq'
include_cookbook 'peco'
include_cookbook 'thunderbolt'

dotfile '.gemrc'
dotfile '.karabiner'
dotfile '.peco'
dotfile '.pryrc'
dotfile '.psqlrc'
dotfile '.railsrc'
dotfile '.rake'
dotfile '.tmux.conf'

template "#{ENV['HOME']}/.config/karabiner/karabiner.json" do
  source File.expand_path('../../../config/karabiner.json', __FILE__)
  is_office = (ENV['USER'] == 'kokubun') # I use "k0kubun" for personal PC
  variables(c_o_app: is_office ? 'Slack.app' : 'Nocturn.app')
end
