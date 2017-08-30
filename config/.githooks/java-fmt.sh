#!/bin/bash -e

# Check if *.java is to be committed or not
cd "$(git rev-parse --show-toplevel)"
files="$(git status --short | grep -E '^[AM] .*\.java$'| cut -d' ' -f3)"
if [ "_${files}" = "_" ]; then
  exit # No Java files are commited. Skip execution.
fi

# Format Java files with one format.sh invocation
echo "Starting IntelliJ IDEA to format Java files..."
echo "$files" | xargs .git/hooks/idea-format.sh -s .git/hooks/codestyle/IntelliJIdea14/Airlift.xml
echo "$files" | xargs git add
