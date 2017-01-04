if node[:platform] != 'darwin'
  package 'zsh'
  dotfile '.zshrc.Linux'
end

dotfile '.zsh'
dotfile '.zshrc'

execute "chsh -s /bin/zsh #{node[:user]}" do
  only_if "getenv passwd #{node[:user]} | cut -d: -f7 | grep -q '/bin/bash'"
  user 'root'
end
