node.reverse_merge!(
  docker: {
    users: [],
  },
)

package 'docker.io'

service 'docker' do
  action :enable
end

node[:docker][:users].each do |user|
  execute "usermod -aG docker #{user.shellescape}" do
    not_if "groups #{user.shellescape} | grep docker -w"
  end
end
