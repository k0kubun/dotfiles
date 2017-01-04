include_cookbook 'dotfiles'

include_cookbook 'urxvt'

directory "#{ENV['HOME']}/bin" do
  owner node[:user]
end

package 'xclip'

dotfile '.peco'
dotfile '.rake'

dotfile '.gemrc'
dotfile '.pryrc'
dotfile '.railsrc'
dotfile '.tmux.conf'
