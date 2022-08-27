directory "#{ENV['HOME']}/.config"

dotfile '.config/nvim'
dotfile '.config/vim'
dotfile '.gemrc'
dotfile '.gitconfig'
dotfile '.gitignore'
dotfile '.karabiner'
dotfile '.peco'
dotfile '.pryrc'
dotfile '.psqlrc'
dotfile '.railsrc'
dotfile '.tmux.conf'
dotfile '.zsh'
dotfile '.zshrc'
dotfile '.zshrc.darwin'

package 'git'

include_recipe 'gpg-agent'

file "#{ENV['HOME']}/.config/karabiner/karabiner.json" do
  yaml_path = File.expand_path('../../../config/karabiner.yml', __FILE__)
  yaml = ERB.new(File.read(yaml_path)).result

  content JSON.pretty_generate(YAML.load(yaml))
end
