case node[:platform]
when 'arch'
  package 'google-chrome-stable'
else
  raise NotImplementedError
end
