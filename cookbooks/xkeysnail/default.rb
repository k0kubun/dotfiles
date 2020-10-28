package 'python3-pip'

execute 'pip3 install xkeysnail' do
  not_if 'test -e /usr/local/bin/xkeysnail'
end

remote_file '/etc/systemd/system/xkeysnail.service' do
  owner 'root'
  group 'root'
  mode '644'
end
