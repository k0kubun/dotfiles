#!/bin/sh

if ! [ -d config/.vim/bundle/neobundle.vim/.git ]; then
  git submodule init && git submodule update --depth 1
fi

sudo bin/itamae local lib/recipe.rb
