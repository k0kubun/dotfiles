package 'git'
include_cookbook 'zsh'

directory "#{ENV['HOME']}/.config"

dotfile '.gemrc'
dotfile '.gitconfig'
dotfile '.gitignore'
dotfile '.karabiner'
dotfile '.peco'
dotfile '.pryrc'
dotfile '.psqlrc'
dotfile '.railsrc'
dotfile '.tmux.conf'
dotfile '.config/nvim'
dotfile '.config/vim'

include_recipe 'gpg-agent'

file "#{ENV['HOME']}/.config/karabiner/karabiner.json" do
  yaml_path = File.expand_path('../../../config/karabiner.yml', __FILE__)
  yaml = ERB.new(File.read(yaml_path)).result

  content JSON.pretty_generate(YAML.load(yaml))
end
