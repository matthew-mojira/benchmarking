#!/bin/bash
set -euo pipefail

if [ $# -eq 0 ]; then
  docker image ls --filter dangling=false --filter label=benchmarking=true --format '{{.Repository}}:{{.Tag}}'
  exit 0
fi

docker run --rm -it "$1"
