define :dotfile do
  link File.join(ENV['HOME'], params[:name]) do
    to File.expand_path("../../../config/#{params[:name]}", __FILE__)
    user node[:user]
  end
end
