case node[:platform]
when 'arch'
  package 'rust'
  package 'cargo'

  include_cookbook 'yaourt'
  yaourt 'rust-src'
else
  local_ruby_block 'install rust' do
    rustc_path = "#{ENV['HOME']}/.cargo/bin/rustc"

    block do
      system("sudo -E -u #{node[:user]} bash -c 'curl https://sh.rustup.rs -sSf | sh'")

      until File.exist?(rustc_path)
        sleep 1
      end
    end
    not_if "test -f #{rustc_path}"
  end
end

unless ENV['PATH'].include?("#{ENV['HOME']}/.cargo/bin:")
  MItamae.logger.info('Prepending ~/.cargo/bin to PATH during this execution')
  ENV['PATH'] = "#{ENV['HOME']}/.cargo/bin:#{ENV['PATH']}"
end

define :cargo do
  execute "cargo install --verbose #{params[:name]}" do
    not_if %Q[cargo install --list | grep "^#{params[:name]} "]
  end
end
