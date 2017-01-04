case node[:platform]
when 'ubuntu'
  package 'chromium-browser'
when 'arch'
  package 'google-chrome-stable'
else
  raise NotImplementedError
end
