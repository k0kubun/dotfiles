# Apply only if wine is already installed.
if run_command('which wine', error: false).exit_status == 0
  package 'wine'

  # 1. Download 1Password.exe from https://agilebits.com/downloads
  # 2. Execute it
  # 3. Open `regedit` and create REG_DWORD "HKEY_CURRENT_USER\Software\AgileBits\1Password 4" with 0.

  remote_file "#{ENV['HOME']}/.config/systemd/user/agile1pagent.service" do
    source 'files/agile1pagent.service'
  end
end
