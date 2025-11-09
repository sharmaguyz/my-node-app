#!/bin/bash
set -euo pipefail

# --- Debug so we see where CodeDeploy is running this from ---
echo "PWD=$(pwd)"
echo "Listing bundle root:"
ls -la

# Ensure dos2unix exists
if ! command -v dos2unix >/dev/null 2>&1; then
  sudo apt-get update -y
  sudo apt-get install -y dos2unix
fi

# Resolve this script's absolute path and the bundle root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUNDLE_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
echo "SCRIPT_DIR=${SCRIPT_DIR}"
echo "BUNDLE_ROOT=${BUNDLE_ROOT}"

# Find all .sh files in the bundle and normalize them
mapfile -t SH_FILES < <(find "${BUNDLE_ROOT}" -type f -name "*.sh" | sort)

if ((${#SH_FILES[@]})); then
  echo "Converting ${#SH_FILES[@]} shell scripts to LF and making them executable..."
  dos2unix "${SH_FILES[@]}" || true
  chmod +x "${SH_FILES[@]}"
  printf '%s\n' "${SH_FILES[@]}" | sed 's/^/   fixed: /'
else
  echo "No .sh files found under ${BUNDLE_ROOT}"
fi
