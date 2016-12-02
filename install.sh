#!/bin/sh
set -e

if ! [ -d config/.vim/bundle/neobundle.vim/.git ]; then
  git submodule init && git submodule update --depth 1
fi

bin/setup

# Homebrew does not allow sudo.
case "$(uname)" in
  "Darwin") bin/mitamae local lib/recipe.rb ;;
  *)   sudo bin/mitamae local lib/recipe.rb ;;
esac
