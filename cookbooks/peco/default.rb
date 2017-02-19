github_binary 'peco' do
  repository 'peco/peco'
  version 'v0.4.7'
  if node[:platform] == 'darwin'
    archive 'peco_darwin_amd64.zip'
    binary_path 'peco_darwin_amd64/peco'
  else
    archive 'peco_linux_amd64.tar.gz'
    binary_path 'peco_linux_amd64/peco'
  end
end

dotfile '.peco'
