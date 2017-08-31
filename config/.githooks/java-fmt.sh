#!/bin/bash -e

# Check if *.java is to be committed or not
repo_root="$(git rev-parse --show-toplevel)"
cd "$repo_root"
files="$(git status --short | grep -E '^[AM] .*\.java$'| cut -d' ' -f3 | sed -e "s|^|$repo_root/|")"
if [ "_${files}" = "_" ]; then
  exit # No Java files are commited. Skip execution.
fi

# Format Java files with one format.sh invocation
echo "Starting IntelliJ IDEA to format Java files..."
echo "$files" | xargs .git/hooks/idea-format.sh -s "$(readlink .git/hooks)/codestyle/IntelliJIdea14/Airlift.xml"
echo "$files" | xargs git add
