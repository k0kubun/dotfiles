#!/bin/bash

set -ex

bin/setup

# Use a special setup on spin
if [[ -n "$SPIN" ]]; then
  sudo -E bin/mitamae local $@ recipes/spin/default.rb
  exit
fi

# Homebrew does not allow sudo.
case "$(uname)" in
  "Darwin")  bin/mitamae local $@ recipes/default.rb ;;
  *) sudo -E bin/mitamae local $@ recipes/default.rb ;;
esac
