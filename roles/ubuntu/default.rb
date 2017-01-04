include_cookbook 'dotfiles'

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
