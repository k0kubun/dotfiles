package 'rxvt-unicode-256color'
package 'fonts-ricty-diminished'

dotfile '.Xdefaults' do
  if `hostname` =~ /\AP\d{3}\n\z/
    source '.Xdefaults.office'
  end
end

include_recipe 'urxvt-perls'
