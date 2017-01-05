include_role 'base'

include_cookbook 'urxvt'
include_cookbook 'xraise'
include_cookbook 'xkremap'
include_cookbook 'google-chrome'
include_cookbook 'skk'
include_cookbook 'git'
include_cookbook 'ghq'
include_cookbook 'peco'
include_cookbook 'zsh'
include_cookbook 'tmux'
include_cookbook 'vim'

if has_package?('wine')
  include_cookbook '1password'
end

package 'compizconfig-settings-manager'

dotfile '.Xmodmap'
dotfile '.rake'
dotfile '.gemrc'
dotfile '.pryrc'
dotfile '.railsrc'
