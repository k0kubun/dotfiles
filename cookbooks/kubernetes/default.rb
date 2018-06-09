package 'apt-transport-https'
package 'curl'

execute 'curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -' do
  only_if %{ test -z "$(apt-key list "54A6 47F9 048D 5688 D7DA  2ABE 6A03 0B21 BA07 F4FB")" }
end

execute 'apt-get update' do
  action :nothing
end

file '/etc/apt/sources.list.d/kubernetes.list' do
  content "deb http://apt.kubernetes.io/ kubernetes-xenial main\n"
  owner 'root'
  group 'root'
  mode '644'
  notifies :run, 'execute[apt-get update]', :immediately
end

package 'kubeadm'
package 'kubectl'
package 'kubelet'
