package 'golang'

gopath = '/home/k0kubun'
execute "env GOPATH=#{gopath} go get golang.org/x/tools/cmd/goimports" do
  not_if "test -e #{gopath}/bin/goimports"
end
