github_binary 'ghq' do
  repository 'motemen/ghq'
  version 'v0.7.4'
  if node[:platform] == 'darwin'
    archive 'ghq_darwin_amd64.zip'
  else
    archive 'ghq_linux_amd64.zip'
  end
end

include_cookbook 'git'
