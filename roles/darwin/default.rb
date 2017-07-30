include_role 'base'

include_cookbook 'git'
include_cookbook 'vim'
include_cookbook 'zsh'
include_cookbook 'ghq'
include_cookbook 'peco'
include_cookbook 'thunderbolt'

dotfile '.gemrc'
dotfile '.karabiner'
dotfile '.peco'
dotfile '.pryrc'
dotfile '.psqlrc'
dotfile '.railsrc'
dotfile '.rake'
dotfile '.tmux.conf'


file "#{ENV['HOME']}/.config/karabiner/karabiner.json" do
  yaml_path = File.expand_path('../../../config/karabiner.yml', __FILE__)
  yaml = ERB.new(File.read(yaml_path)).result

  content YAML.load(yaml).to_json
end
