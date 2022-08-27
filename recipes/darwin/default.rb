include_cookbook 'git'
include_cookbook 'vim'
include_cookbook 'zsh'

dotfile '.gemrc'
dotfile '.karabiner'
dotfile '.peco'
dotfile '.pryrc'
dotfile '.psqlrc'
dotfile '.railsrc'
dotfile '.rake'
dotfile '.tmux.conf'

include_recipe 'gpg-agent'

file "#{ENV['HOME']}/.config/karabiner/karabiner.json" do
  yaml_path = File.expand_path('../../../config/karabiner.yml', __FILE__)
  yaml = ERB.new(File.read(yaml_path)).result

  content JSON.pretty_generate(YAML.load(yaml))
end
