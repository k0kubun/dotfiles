if node[:platform] != 'darwin'
  package 'zsh'
end

dotfile '.zsh'
dotfile '.zshrc'
