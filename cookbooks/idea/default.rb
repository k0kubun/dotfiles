node.reverse_merge!(
  idea: {
    path: '/opt/idea-IU-203.7148.57',
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
