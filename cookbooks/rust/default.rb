package 'rust'
package 'cargo'

define :cargo do
  execute "cargo install --verbose #{params[:name]}" do
    not_if %Q[cargo install --list | grep "^#{params[:name]} "]
  end
end

cargo 'rustfmt'
cargo 'racer'

define :yaourt do
  name = params[:name].shellescape
  execute "yaourt -S --noconfirm #{name}" do
    not_if "yaourt -Q #{name} || yaourt -Qg #{name}" # TODO: check group properly
    if ENV['SUDO_USER']
      user ENV['SUDO_USER']
    end
  end
end

yaourt 'rust-src'
