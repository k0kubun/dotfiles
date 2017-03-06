github_binary 'ghq' do
  repository 'motemen/ghq'
  version 'v0.7.4'
  archive "ghq_#{node[:os]}_amd64.zip"
end

include_cookbook 'git'
