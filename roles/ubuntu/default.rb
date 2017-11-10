include_role 'base'

include_cookbook 'urxvt'
include_cookbook 'xremap'
include_cookbook 'skk'
include_cookbook 'git'
include_cookbook 'ghq'
include_cookbook 'peco'
include_cookbook 'zsh'
include_cookbook 'tmux'
include_cookbook 'vim'
include_cookbook 'thunderbolt'

if has_package?('wine')
  include_cookbook '1password'
end

dotfile '.Xmodmap'
dotfile '.rake'
dotfile '.gemrc'
dotfile '.pryrc'
dotfile '.railsrc'
dotfile '.gtkrc-2.0'

include_recipe 'ssh-agent'

# For TZ=UTC
remote_file '/lib/systemd/system/mysql.service' do
  owner 'root'
  group 'root'
  mode '644'
  only_if 'which mysql'
end

link "#{ENV['HOME']}/.git-template/hooks" do
  to "#{ENV['HOME']}/.githooks"
end
