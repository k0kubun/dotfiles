include_cookbook 'dotfiles'

directory "#{ENV['HOME']}/bin" do
  owner node[:user]
end

dotfile '.peco'
dotfile '.rake'

dotfile '.Xdefaults'
dotfile '.gemrc'
dotfile '.pryrc'
dotfile '.railsrc'
dotfile '.tmux.conf'
