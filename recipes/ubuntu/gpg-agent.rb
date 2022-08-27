package 'gnupg-agent'

directory "#{ENV['HOME']}/.gnupg" do
  owner node[:user]
  group node[:user]
end

remote_file "#{ENV['HOME']}/.gnupg/gpg-agent.conf" do
  source 'files/gpg-agent.conf'
  owner node[:user]
  group node[:user]
end

file '/usr/lib/systemd/user/gpg-agent.service' do
  action :edit
  block do |content|
    unless content.include?('[Install]')
      content.gsub!(/\z/, "\n[Install]\nWantedBy=default.target\n")
    end
  end
end

user_service 'gpg-agent' do
  action [:start, :enable]
end

user_service 'gpg-agent.socket' do
  action [:start, :enable]
end
