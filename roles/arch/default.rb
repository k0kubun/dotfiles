include_cookbook 'dotfiles'

directory "#{ENV['HOME']}/bin" do
  owner node[:user]
end

include_cookbook 'git'
include_cookbook 'vim'
include_cookbook 'zsh'
include_cookbook 'rust'

cargo 'xraise'

dotfile '.peco'
dotfile '.rake'

dotfile '.Xdefaults'
dotfile '.gemrc'
dotfile '.gtkrc-2.0'
dotfile '.pryrc'
dotfile '.railsrc'
dotfile '.rbindkeys'
dotfile '.tmux.conf'
dotfile '.xinitrc'
