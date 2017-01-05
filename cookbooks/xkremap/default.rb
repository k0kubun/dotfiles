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

remote_file "#{ENV['HOME']}/.config/systemd/user/xkremap.service" do
  source 'files/xkremap.service'
end

user_service 'xkremap' do
  action [:enable, :start]
end

dotfile '.xkremap'
