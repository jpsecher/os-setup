#!/usr/bin/env bash

scriptdir=$(realpath "$(dirname "$0")")
workdir=${WORKSPACE:-$(realpath "$scriptdir/..")}

pushd "$workdir" > /dev/null || exit 1

output_file=darwin-files
date > "${output_file}.lst"
for dir in darwin-nix; do
  find "$dir" -type f \( -name '*.nix' \) -a -not \( -name '*.lock' \) | \
  tee -a "${output_file}.lst" | \
  while read -r file; do
    echo "=== $file ==="
    cat "$file"
    echo
  done
done > "${output_file}.txt"

popd > /dev/null || exit 1
