define :dotfile do
  if params[:name].is_a?(String)
    links = { params[:name] => params[:name] }
  else
    links = params[:name]
  end

  links.each do |link_from, link_to|
    directory File.dirname(link_from = File.join(ENV['HOME'], link_from)) do
      user node[:user]
    end

    link link_from do
      to File.expand_path("../../../config/#{link_to}", __FILE__)
      user node[:user]
      force true
    end
  end
end

define :github_binary, version: nil, repository: nil, archive: nil, binary_path: nil do
  cmd = params[:name]
  bin_path = "#{ENV['HOME']}/bin/#{cmd}"
  archive = params[:archive]
  url = "https://github.com/#{params[:repository]}/releases/download/#{params[:version]}/#{archive}"

  if archive.end_with?('.zip')
    package 'unzip' do
      not_if 'which unzip'
    end
    extract = "unzip -o"
  elsif archive.end_with?('.tar.gz')
    extract = "tar xvzf"
  else
    raise "unexpected ext archive: #{archive}"
  end

  directory "#{ENV['HOME']}/bin" do
    owner node[:user]
  end
  execute "curl -fSL -o /tmp/#{archive} #{url}" do
    not_if "test -f #{bin_path}"
  end
  execute "#{extract} /tmp/#{archive}" do
    not_if "test -f #{bin_path}"
    cwd "/tmp"
  end
  execute "mv /tmp/#{params[:binary_path] || cmd} #{bin_path} && chmod +x #{bin_path}" do
    not_if "test -f #{bin_path}"
  end
end
