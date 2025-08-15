dotfile '.config/nvim/coc-settings.json'
dotfile '.config/nvim/init.vim'
dotfile '.gitconfig'
dotfile '.peco'
dotfile '.tmux.conf'
dotfile '.tmux.conf.local' => '.tmux.conf.linux'
dotfile '.zsh'
dotfile '.zshrc'
dotfile '.zshrc.Linux'

package 'tmux'
package 'zsh'
package 'neovim'
package 'nodejs'
package 'npm'

execute "chsh -s /bin/zsh #{node[:user]}" do
  only_if "getent passwd #{node[:user]} | cut -d: -f7 | grep -q '^/bin/bash$'"
  user 'root'
end
