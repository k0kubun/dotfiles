package 'tmux'

dotfile '.tmux.conf'
dotfile '.tmux.conf.local' do
  source '.tmux.conf.linux'
end

package 'xclip'
