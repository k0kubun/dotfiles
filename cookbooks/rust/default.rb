package 'rust'
package 'cargo'

define :cargo do
  execute "cargo install --verbose #{params[:name]}" do
    not_if %Q[cargo install --list | grep "^#{params[:name]} "]
  end
end

cargo 'rustfmt'
cargo 'racer'
