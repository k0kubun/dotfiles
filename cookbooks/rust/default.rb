package 'rust'
package 'cargo'

define :cargo do
  execute "cargo install --verbose #{params[:name]}" do
    not_if "which #{params[:name]}" # should check crates
  end
end

cargo 'rustfmt'
cargo 'racer'
