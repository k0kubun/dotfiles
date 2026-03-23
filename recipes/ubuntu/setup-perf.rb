remote_file '/etc/sysctl.d/99-perf.conf' do
  owner 'root'
  group 'root'
  mode '644'
  notifies :run, 'execute[sysctl --system]'
end

execute 'sysctl --system' do
  action :nothing
end
