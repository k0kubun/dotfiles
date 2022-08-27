directory "#{ENV['HOME']}/bin" do
  owner node[:user]
end

if run_command('test -d /etc/systemd', error: false).exit_status == 0
  [
    "#{ENV['HOME']}/.config",
    "#{ENV['HOME']}/.config/systemd",
    "#{ENV['HOME']}/.config/systemd/user",
  ].each do |dir|
    directory dir do
      owner node[:user]
    end
  end
end

include_cookbook 'functions'
