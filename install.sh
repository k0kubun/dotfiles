#!/bin/sh

set -ex

if [[ -n "$SPIN" ]]; then
  exit # spin is not supported
fi

bin/setup

# Homebrew does not allow sudo.
case "$(uname)" in
  "Darwin")  bin/mitamae local $@ recipes/default.rb ;;
  *) sudo -E bin/mitamae local $@ recipes/default.rb ;;
esac
