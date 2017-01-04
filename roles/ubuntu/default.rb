include_role 'base'

include_cookbook 'urxvt'
include_cookbook 'xkremap'
include_cookbook 'google-chrome'
include_cookbook 'skk'
include_cookbook 'ghq'
include_cookbook 'peco'

package 'xclip'

dotfile '.peco'
dotfile '.rake'

dotfile '.gemrc'
dotfile '.pryrc'
dotfile '.railsrc'
dotfile '.tmux.conf'
