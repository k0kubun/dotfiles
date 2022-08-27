node.reverse_merge!(
  os: run_command('uname').stdout.strip.downcase,
  user: ENV['SUDO_USER'] || ENV['USER'],
)

include_recipe 'base'
include_recipe node[:platform]
