github_binary 'peco' do
  repository 'peco/peco'
  version 'v0.5.1'
  ext = (node[:platform] == 'darwin' ? 'zip' : 'tar.gz')
  archive "peco_#{node[:os]}_amd64.#{ext}"
  binary_path "peco_#{node[:os]}_amd64/peco"
end

dotfile '.peco'
