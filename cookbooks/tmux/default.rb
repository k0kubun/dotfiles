package 'tmux'

dotfile '.tmux.conf'
dotfile '.tmux.conf.local' do
  source '.tmux.conf.arch'
end

package 'xclip'
