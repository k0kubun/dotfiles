package 'wmctrl'

remote_file "#{ENV['HOME']}/.config/systemd/user/xremap.service" do
  owner node[:user]
  group node[:user]
end

remote_file "#{ENV['HOME']}/.config/autostart/xremap.desktop" do
  owner node[:user]
  group node[:user]
end
