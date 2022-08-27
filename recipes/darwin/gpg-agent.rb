directory "#{ENV['HOME']}/.gnupg" do
  owner node[:user]
end

remote_file "#{ENV['HOME']}/.gnupg/gpg-agent.conf" do
  source 'files/gpg-agent.conf'
  owner node[:user]
end

package 'gnupg'
package 'pinentry-mac'
