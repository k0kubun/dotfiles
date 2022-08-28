directory "#{ENV['HOME']}/.config"

dotfile '.Xmodmap'
dotfile '.config/nvim'
dotfile '.gdbinit'
dotfile '.gemrc'
dotfile '.gitconfig'
dotfile '.gitignore'
dotfile '.gtkrc-2.0'
dotfile '.ideavimrc'
dotfile '.irbrc'
dotfile '.peco'
dotfile '.pryrc'
dotfile '.railsrc'
dotfile '.tmux.conf'
dotfile '.tmux.conf.local' => '.tmux.conf.linux'
dotfile '.zsh'
dotfile '.zshrc'
dotfile '.zshrc.Linux'

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

# For dual boot Windows
execute 'timedatectl set-local-rtc true' do
  only_if "timedatectl status | grep 'RTC in local TZ: no'"
end
