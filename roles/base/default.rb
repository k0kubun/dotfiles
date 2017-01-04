include_cookbook 'dotfiles'

directory "#{ENV['HOME']}/bin" do
  owner node[:user]
end
