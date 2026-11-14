#!/bin/bash
set -euo pipefail

# Python

# cpython
while IFS=$'\t' read -r version commit build_configs; do
  IFS=, read -r -a configs <<< "$build_configs"
  for config in "${configs[@]}"; do
    docker build --target "cpython-$version-$config" \
      --label benchmarking=true \
      -t "python/cpython:$version-$config" . < /dev/null
  done
done < <(tail -n +2 versions/cpython.tsv)
