directory "#{ENV['HOME']}/.gnupg" do
  owner node[:user]
  group node[:user]
end

remote_file "#{ENV['HOME']}/.gnupg/gpg-agent.conf" do
  source 'files/gpg-agent.conf'
  owner node[:user]
  group node[:user]
end

user_service 'gpg-agent' do
  action :start
end
