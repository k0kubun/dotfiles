remote_file "#{ENV['HOME']}/.config/systemd/user/ssh-agent.service" do
  source 'files/ssh-agent.service'
  owner node[:user]
  group node[:user]
end

remote_file "#{ENV['HOME']}/.pam-environment" do
  source 'files/.pam-environment'
end

link "#{ENV['HOME']}/.config/systemd/user/default.target.wants/ssh-agent.service" do
  to "#{ENV['HOME']}/.config/systemd/user/ssh-agent.service"
end

user_service 'ssh-agent' do
  action :start
end
