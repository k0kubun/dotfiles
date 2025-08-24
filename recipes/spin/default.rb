include_recipe '../base'

remote_file '/home/spin/.zshrc' do
  owner node[:user]
end
