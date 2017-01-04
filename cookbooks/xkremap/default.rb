node.reverse_merge!(
  xkremap: {
    repo_path: "#{ENV['HOME']}/src/github.com/k0kubun/xkremap",
  }
)
package 'bison'
package 'libx11-dev'
package 'ruby'

git node[:xkremap][:repo_path] do
  repository 'https://github.com/k0kubun/xkremap'
  not_if 'which xkremap'
  user node[:user]
end

execute 'make && make install' do
  cwd node[:xkremap][:repo_path]
  not_if 'which xkremap'
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

remote_file "#{ENV['HOME']}/.config/systemd/user/xkremap.service" do
  source 'xkremap.service'
end

execute 'systemctl --user enable xkremap && systemctl --user start xkremap' do
  not_if 'ps aux | grep -q xkremap'
  user node[:user]
end

dotfile '.xkremap'
