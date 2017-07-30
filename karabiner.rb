#!/usr/bin/env ruby

require 'json'
require 'yaml'

json_path = File.expand_path('./config/karabiner.json', __dir__)
yaml_path = File.expand_path('./config/karabiner.yml', __dir__)

case ARGV.first
when 'export'
  File.write(yaml_path, File.read(json_path).to_yaml)
when 'generate'
  File.write(json_path, File.read(yaml_path).to_yaml)
else
  $stderr.puts <<~EOS
    Usage:
      ./karabiner.rb export      # JSON -> YAML
      ./karabiner.rb generate    # YAML -> JSON
  EOS
end
