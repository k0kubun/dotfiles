directory "#{ENV['HOME']}/.gnupg" do
  owner node[:user]
  group node[:user]
end

remote_file "#{ENV['HOME']}/.gnupg/gpg-agent.conf" do
  source 'files/gpg-agent.conf'
  owner node[:user]
  group node[:user]
end

remote_file "#{ENV['HOME']}/.config/systemd/user/gpg-agent.service" do
  source 'files/gpg-agent.service'
  owner node[:user]
  group node[:user]
end

link "#{ENV['HOME']}/.config/systemd/user/default.target.wants/gpg-agent.service" do
  to "#{ENV['HOME']}/.config/systemd/user/gpg-agent.service"
end

user_service 'gpg-agent' do
  action :start
end
