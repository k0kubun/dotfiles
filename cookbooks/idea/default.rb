idea = Dir.glob('/opt/idea-IU-*').first
return if idea.nil?

node.reverse_merge!(
  idea: {
    path: idea,
  }
)

template '/usr/share/applications/idea.desktop' do
  owner 'root'
  group 'root'
  mode '644'
  variables(
    path: node[:idea][:path],
  )
end
