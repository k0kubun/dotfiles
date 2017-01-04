include_cookbook 'dotfiles'
include_cookbook 'urxvt-perls'

directory "#{ENV['HOME']}/bin" do
  owner node[:user]
end

package 'xclip'
package 'xsel'

dotfile '.peco'
dotfile '.rake'

dotfile '.gemrc'
dotfile '.pryrc'
dotfile '.railsrc'
dotfile '.tmux.conf'
