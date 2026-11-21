remote_file "#{ENV['HOME']}/.config/systemd/user/agentx.service" do
  source 'files/agentx.service'
  owner node[:user]
  group node[:user]
end

link "#{ENV['HOME']}/.config/systemd/user/default.target.wants/agentx.service" do
  to "#{ENV['HOME']}/.config/systemd/user/agentx.service"
end

# Keep serving while nobody is logged in.
execute "loginctl enable-linger #{node[:user]}" do
  not_if "test -f /var/lib/systemd/linger/#{node[:user]}"
end

user_service 'agentx' do
  action :start
end
