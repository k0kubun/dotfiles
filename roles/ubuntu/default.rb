node.reverse_merge!(
  docker: {
    users: %w[k0kubun],
  },
)

include_role 'base'

include_cookbook 'skk'
include_cookbook 'git'
include_cookbook 'ghq'
include_cookbook 'peco'
include_cookbook 'zsh'
include_cookbook 'tmux'
include_cookbook 'vim'
include_cookbook 'xkeysnail'
# include_cookbook 'thunderbolt'
include_cookbook 'docker'
# include_cookbook 'kubernetes'

if has_package?('wine') || has_package?('wine-stable')
  include_cookbook '1password'
end

dotfile '.Xmodmap'
# dotfile '.rake'
dotfile '.gemrc'
dotfile '.irbrc'
dotfile '.pryrc'
dotfile '.railsrc'
dotfile '.gdbinit'
dotfile '.gtkrc-2.0'

directory "#{ENV['HOME']}/.config/systemd/user/default.target.wants" do
  owner node[:user]
  group node[:user]
  mode '755'
end

include_recipe 'ssh-agent'
include_recipe 'gpg-agent'
# include_recipe 'ddns-update'

# For TZ=UTC
# remote_file '/lib/systemd/system/mysql.service' do
#   owner 'root'
#   group 'root'
#   mode '644'
#   only_if 'which mysql'
# end
