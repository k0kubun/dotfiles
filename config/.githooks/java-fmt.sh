#!/bin/bash -e

# Check if *.java is to be committed or not
repo_root="$(git rev-parse --show-toplevel)"
cd "$repo_root"
files="$(git status --short | grep -E '^[AM] .*\.java$'| cut -d' ' -f3 | sed -e "s|^|$repo_root/|")"
if [ "_${files}" = "_" ]; then
  exit # No Java files are commited. Skip execution.
fi
