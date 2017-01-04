case node[:platform]
when 'arch'
  package 'rust'
  package 'cargo'

  include_cookbook 'yaourt'
  yaourt 'rust-src'
end

define :cargo do
  execute "cargo install --verbose #{params[:name]}" do
    not_if %Q[cargo install --list | grep "^#{params[:name]} "]
  end
end
