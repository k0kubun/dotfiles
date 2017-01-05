# Apply only if wine is already installed.
if run_command('which wine', error: false).exit_status == 0
  package 'wine'

  # 1. Do `winecfg` to update dpy
  # 2. Download 1Password.exe from https://agilebits.com/downloads
  # 3. Execute it
  # 4. Open `regedit` and create VerifyCodeSignature,
  #    REG_DWORD "HKEY_CURRENT_USER\Software\AgileBits\1Password 4" with 0.

  remote_file "#{ENV['HOME']}/.config/systemd/user/agile1pagent.service" do
    source 'files/agile1pagent.service'
  end
end
