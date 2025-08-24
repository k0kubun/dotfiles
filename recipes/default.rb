include_recipe 'base'
if node[:kernel][:release] =~ /microsoft/i
  include_recipe 'wsl'
else
  include_recipe node[:platform]
end
