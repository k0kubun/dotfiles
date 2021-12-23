template "#{ENV['HOME']}/.config/systemd/user/xremap.service" do
  owner node[:user]
  group node[:user]
end

link "#{ENV['HOME']}/.config/systemd/user/default.target.wants/xremap.service" do
  to "#{ENV['HOME']}/.config/systemd/user/xremap.service"
end
