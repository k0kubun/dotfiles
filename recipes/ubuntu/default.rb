node.reverse_merge!(
  docker: {
    users: %w[k0kubun],
  },
)

include_recipe 'systemd'
include_cookbook 'skk'
include_cookbook 'zsh'
include_cookbook 'tmux'
include_cookbook 'vim'
include_cookbook 'ruby'
# include_cookbook 'go'
include_cookbook 'docker'
include_cookbook 'nocturn'
include_cookbook 'idea'

package 'git'
package 'fzf'

dotfile '.Xmodmap'
dotfile '.gdbinit'
dotfile '.gemrc'
dotfile '.gitconfig'
dotfile '.gitignore'
dotfile '.gtkrc-2.0'
dotfile '.irbrc'
dotfile '.peco'
dotfile '.pryrc'
dotfile '.railsrc'

directory "#{ENV['HOME']}/.config/systemd/user/default.target.wants" do
  owner node[:user]
  group node[:user]
  mode '755'
end

include_recipe 'ssh-agent'
include_recipe 'gpg-agent'
include_recipe 'ddns-update'
include_recipe 'xremap'

# For TZ=UTC
# remote_file '/lib/systemd/system/mysql.service' do
#   owner 'root'
#   group 'root'
#   mode '644'
#   only_if 'which mysql'
# end

# For dual boot Windows
execute 'timedatectl set-local-rtc true' do
  only_if "timedatectl status | grep 'RTC in local TZ: no'"
end
