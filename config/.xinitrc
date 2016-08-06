#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
  xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
  xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
  xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
  xmodmap "$usermodmap"
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# disable beep sound
xset b off

# accererate key repeat
xset r rate 200 80

# disable screen blackout
xset dpms 0 0 0
xset s off

#trayer --edge top --SetDockType true --SetPartialStrut true \
#  --expand true --width 10 --transparent true --tint 0x131418 --alpha 0 --height 24 &

pulseaudio --start

ibus-daemon &
xscreensaver -no-splash &

#compton &

# start some nice programs
exec gnome-session
