package 'wmctrl'

remote_file '/etc/X11/xorg.conf.d/00-keyboard.conf' do
  owner 'root'
  group 'root'
  mode '644'
end
