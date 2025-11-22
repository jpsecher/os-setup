#!/usr/bin/env bash

scriptdir=$(realpath "$(dirname "$0")")
workdir=${WORKSPACE:-$(realpath "$scriptdir/..")}

pushd "$workdir" > /dev/null || exit 1

output_file=.meta/os-setup-files
date > "${output_file}.lst"
for dir in nix nixos darwin-nix; do
  find "$dir" -type f -name '*.nix' ! -name '*.lock' ! -name '*hardware-configuration.nix' ! -path 'nixos/*/*' | \
  tee -a "${output_file}.lst" | \
  while read -r file; do
    echo "=== $file ==="
    cat "$file"
    echo
  done
done > "${output_file}.txt"

popd > /dev/null || exit 1
