define :dotfile, source: nil do
  source = params[:source] || params[:name]
  link File.join(ENV['HOME'], params[:name]) do
    to File.expand_path("../../../config/#{source}", __FILE__)
    user node[:user]
  end
end

define :github_binary, version: nil, repository: nil, archive: nil do
  command = params[:name]
  path = "#{ENV['HOME']}/bin/#{command}"
  archive = params[:archive]
  url = "https://github.com/#{params[:repository]}/releases/download/#{params[:version]}/peco_linux_amd64.tar.gz"

  if archive.end_with?('.zip')
    extract = "unzip"
  elsif archive.end_with?('.tar.gz')
    extract = "tar xvzf"
  else
    raise "unexpected ext archive: #{archive}"
  end

  execute "curl -fsSL -o /tmp/#{archive} #{url} && #{extract} /tmp/#{archive} && mv /tmp/#{command} #{path} && chmod +x #{path}" do
    not_if "test -f #{path}"
  end
end
