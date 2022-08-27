directory "#{ENV['HOME']}/.config"

dotfile '.Xmodmap'
dotfile '.config/nvim'
dotfile '.config/vim'
dotfile '.gdbinit'
dotfile '.gemrc'
dotfile '.gitconfig'
dotfile '.gitignore'
dotfile '.gtkrc-2.0'
dotfile '.irbrc'
dotfile '.peco'
dotfile '.pryrc'
dotfile '.railsrc'
dotfile '.tmux.conf'
dotfile '.zsh'
dotfile '.zshrc'
dotfile '.zshrc.Linux'

dotfile '.tmux.conf.local' do
  source '.tmux.conf.linux'
end

include_recipe 'systemd'
include_recipe 'skk'
include_recipe 'zsh'
include_recipe 'ruby'
include_recipe 'docker'
include_recipe 'nocturn'

package 'tmux'
package 'xclip'
package 'git'
package 'fzf'

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
