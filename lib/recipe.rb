include_recipe 'recipe_helper'

node.reverse_merge!(
  user: ENV['SUDO_USER'] || ENV['USER'],
)
include_recipe "../recipes/#{node[:platform]}"
