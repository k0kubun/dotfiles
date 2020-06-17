package 'git'

if node[:platform] == 'darwin'
  # Remove:
  # [filesystem "Azul Systems, Inc.|1.8.0_222|/dev/disk1s5"]
  # [filesystem "Oracle Corporation|1.8.0_221|/dev/disk1s5"]
  file(gitconfig = File.join(ENV['HOME'], '.gitconfig')) do
    action :delete
    only_if { File.file?(gitconfig) && !File.symlink?(gitconfig) }
  end
end

dotfile '.gitconfig'
dotfile '.gitignore'
