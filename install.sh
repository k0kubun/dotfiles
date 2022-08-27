#!/bin/sh

set -ex

if [ ! -f config/.config/nvim/dein/repos/github.com/Shougo/dein.vim/.git ]; then
  git submodule init && git submodule update --depth 1
fi

bin/setup

# Homebrew does not allow sudo.
case "$(uname)" in
  "Darwin")  bin/mitamae local $@ recipes/default.rb ;;
  *) sudo -E bin/mitamae local $@ recipes/default.rb ;;
esac
