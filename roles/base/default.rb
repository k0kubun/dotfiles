directory "#{ENV['HOME']}/bin" do
  owner node[:user]
end

[
  "#{ENV['HOME']}/.config",
  "#{ENV['HOME']}/.config/systemd",
  "#{ENV['HOME']}/.config/systemd/user",
].each do |dir|
  directory dir do
    owner node[:user]
  end
end

include_cookbook 'functions'
