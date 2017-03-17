github_binary 'peco' do
  repository 'peco/peco'
  version 'v0.5.1'
  archive "peco_#{node[:os]}_amd64.zip"
  binary_path "peco_#{node[:os]}_amd64/peco"
end

dotfile '.peco'
