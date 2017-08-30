#!/bin/bash -e

# Find IntelliJ IDEA's format.sh
formatter_paths=(
  "/opt/local/idea/bin/format.sh"
  "/Applications/IntelliJ IDEA CE.app/Contents/bin/format.sh"
)
for path in "${formatter_paths[@]}"; do
  if [ -e "$path" ]; then
    formatter_path="$path"
    break
  fi
done

if [ "_${formatter_path}" = "_" ]; then
  >&2 echo "IDEA's format.sh was not found. Skipping idea-format.sh."
  exec true
else
  exec "$formatter_path" "$@"
fi
