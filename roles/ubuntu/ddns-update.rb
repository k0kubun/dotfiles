directory '/opt/local/ddns-update' do
  owner node[:user]
  group node[:user]
  mode '755'
end

remote_file '/opt/local/ddns-update/update.sh' do
  owner node[:user]
  group node[:user]
  mode '775'
end

remote_file '/opt/local/ddns-update/current' do
  owner node[:user]
  group node[:user]
  mode '644'
  not_if 'test -f /opt/local/ddns-update/current'
end

%w[
  /opt/local/ddns-update/username
  /opt/local/ddns-update/password
].each do |f|
  remote_file f do
    owner node[:user]
    group node[:user]
    mode '600'
    not_if "test -f #{f}"
  end
end

remote_file "#{ENV['HOME']}/.config/systemd/user/ddns-update.service" do
  source 'files/ddns-update.service'
  owner node[:user]
  group node[:user]
end

remote_file "#{ENV['HOME']}/.config/systemd/user/ddns-update.timer" do
  source 'files/ddns-update.timer'
  owner node[:user]
  group node[:user]
end

link "#{ENV['HOME']}/.config/systemd/user/timers.target.wants/ddns-update.timer" do
  to "#{ENV['HOME']}/.config/systemd/user/ddns-update.timer"
end
