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
dotfile '.config/vim'
