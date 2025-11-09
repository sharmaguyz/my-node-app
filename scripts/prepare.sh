#!/bin/bash
set -euo pipefail

# Resolve to this script's directory (the /scripts folder in the bundle)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Ensure tools
if ! command -v dos2unix >/dev/null 2>&1; then
  sudo apt-get update -y
  sudo apt-get install -y dos2unix
fi

# Normalize line endings and permissions for all shell scripts in /scripts
cd "$SCRIPT_DIR"
# Convert only if there are matches
shopt -s nullglob
FILES=( ./*.sh )
if ((${#FILES[@]})); then
  dos2unix "${FILES[@]}" || true
  chmod +x "${FILES[@]}"
else
  echo "No .sh files found in $SCRIPT_DIR to convert."
fi
