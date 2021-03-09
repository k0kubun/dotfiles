# package 'vim'
case node[:platform]
when 'ubuntu'
  # package 'vim-gtk'
end

#
# NeoVim
#
directory "#{ENV['HOME']}/.config"

dotfile '.config/nvim'

#
# Vim
#
dotfile '.vimrc'

directory "#{ENV['HOME']}/.config/vim/dein/repos/github.com/Shougo"

dotfile '.config/vim/dein/repos/github.com/Shougo/dein.vim' do
  source '.config/nvim/dein/repos/github.com/Shougo/dein.vim'
end

dotfile '.config/vim/dein.toml' do
  source '.config/nvim/dein.toml'
end

dotfile '.config/vim/dein_lazy.toml' do
  source '.config/nvim/dein_lazy.toml'
end
