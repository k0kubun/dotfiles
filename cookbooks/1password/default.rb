package 'wine'

exe_url   = "https://d13itkw33a7sus.cloudfront.net/dist/1P/win4/1Password-4.6.1.617.exe"
exe_sha1  = "1f7cd4115b1d0908765d97289e0d31a77dbe8948"
dest_path = "#{ENV['HOME']}/.wine/drive_c/Program Files (x86)/1Password 4/1Password.exe"

execute "curl -fSL -o /tmp/1Password.exe #{exe_url}" do
  user node[:user]
  not_if "test -f #{dest_path.shellescape}"
  verify "echo #{exe_sha1}  /tmp/1Password.exe | sha1sum --status --check -"
end

execute "wine /tmp/1Password.exe" do
  user node[:user]
  not_if "test -f #{dest_path.shellescape}"
end

local_ruby_block 'wait wine installation' do
  block do
    sleep 1 until File.exist?(dest_path)
  end
  not_if "test -f #{dest_path.shellescape}"
end

file "#{ENV['HOME']}/.wine/user.reg" do
  action :edit
  block do |content|
    config = '"VerifyCodeSignature"=dword:00000000'
    unless content.include?(config)
      content.gsub!(
        /^\[Software\\\\AgileBits\\\\1Password 4\].*\n("[A-U].*\n)*/,
        "\\0#{config}\n",
      )
    end
  end
end

remote_file "#{ENV['HOME']}/.config/systemd/user/agile1pagent.service" do
  source 'files/agile1pagent.service'
end

user_service 'agile1pagent' do
  action [:enable, :start]
end
