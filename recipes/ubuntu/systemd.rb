[
  '.config',
  '.config/systemd',
  '.config/systemd/user',
].each do |dir|
  directory "#{ENV['HOME']}/#{dir}" do
    owner node[:user]
  end
end
