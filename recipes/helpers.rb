MItamae::RecipeContext.class_eval do
  def include_cookbook(name)
    root_dir = File.expand_path('../..', __FILE__)
    include_recipe File.join(root_dir, 'cookbooks', name, 'default')
  end
end

define :dotfile, source: nil do
  source = params[:source] || params[:name]
  link File.join(ENV['HOME'], params[:name]) do
    to File.expand_path("../../config/#{source}", __FILE__)
    user node[:user]
    force true
  end
end

define :github_binary, version: nil, repository: nil, archive: nil, binary_path: nil do
  cmd = params[:name]
  bin_path = "#{ENV['HOME']}/bin/#{cmd}"
  archive = params[:archive]
  url = "https://github.com/#{params[:repository]}/releases/download/#{params[:version]}/#{archive}"

  if archive.end_with?('.zip')
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
