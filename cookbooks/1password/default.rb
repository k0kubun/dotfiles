# Apply only if wine is already installed.
if run_command('which wine', error: false).exit_status == 0
  package 'wine'

  # 1. Do `winecfg` to update dpy
  # 2. Download 1Password.exe from https://agilebits.com/downloads
  # 3. Execute it

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
end
