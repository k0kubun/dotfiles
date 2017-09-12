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

# For TZ=UTC
remote_file '/lib/systemd/system/mysql.service' do
  owner 'root'
  group 'root'
  mode '644'
  only_if 'which mysql'
end

remote_file "#{ENV['HOME']}/.config/systemd/user/ssh-agent.service" do
  source 'files/ssh-agent.service'
  owner node[:user]
  group node[:user]
end

remote_file "#{ENV['HOME']}/.pam-environment" do
  source 'files/.pam-environment'
end

link "#{ENV['HOME']}/.config/systemd/user/default.target.wants/ssh-agent.service" do
  to "#{ENV['HOME']}/.config/systemd/user/ssh-agent.service"
end

user_service 'ssh-agent' do
  action :start
end

link "#{ENV['HOME']}/.git-template/hooks" do
  to "#{ENV['HOME']}/.githooks"
end
