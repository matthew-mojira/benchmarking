#!/bin/bash
#set -euo pipefail
set -uo pipefail

AFFINITY=0-11

mkdir -p results

# cpython
# while IFS=$'\t' read -r version commit build_configs; do
#   IFS=, read -r -a configs <<< "$build_configs"
#   for config in "${configs[@]}"; do
#     docker run --rm -v "$PWD/results:/results" "python/cpython:$version-$config" \
#       /opt/pyperformance/bin/pyperformance run \
#         --python="/opt/bin/cpython-$version-$config" \
#         -o "/results/cpython-$version-$config.json" < /dev/null
#   done
# done < <(tail -n +2 versions/cpython.tsv)

docker run --rm -v "$PWD/results:/results" python/cpython:3.10.22-default /opt/pyperformance/bin/pyperformance run -f --affinity="$AFFINITY" --python=/opt/bin/cpython-3.10.22-default -o /results/cpython-3.10.22-default.json
docker run --rm -v "$PWD/results:/results" python/cpython:3.10.22-opt /opt/pyperformance/bin/pyperformance run -f --affinity="$AFFINITY" --python=/opt/bin/cpython-3.10.22-opt -o /results/cpython-3.10.22-opt.json
docker run --rm -v "$PWD/results:/results" python/cpython:3.11.18-default /opt/pyperformance/bin/pyperformance run -f --affinity="$AFFINITY" --python=/opt/bin/cpython-3.11.18-default -o /results/cpython-3.11.18-default.json
docker run --rm -v "$PWD/results:/results" python/cpython:3.11.18-opt /opt/pyperformance/bin/pyperformance run -f --affinity="$AFFINITY" --python=/opt/bin/cpython-3.11.18-opt -o /results/cpython-3.11.18-opt.json
docker run --rm -v "$PWD/results:/results" python/cpython:3.12.16-default /opt/pyperformance/bin/pyperformance run -f --affinity="$AFFINITY" --python=/opt/bin/cpython-3.12.16-default -o /results/cpython-3.12.16-default.json
docker run --rm -v "$PWD/results:/results" python/cpython:3.12.16-opt /opt/pyperformance/bin/pyperformance run -f --affinity="$AFFINITY" --python=/opt/bin/cpython-3.12.16-opt -o /results/cpython-3.12.16-opt.json
docker run --rm -v "$PWD/results:/results" python/cpython:3.13.18-default /opt/pyperformance/bin/pyperformance run -f --affinity="$AFFINITY" --python=/opt/bin/cpython-3.13.18-default -o /results/cpython-3.13.18-default.json
docker run --rm -v "$PWD/results:/results" python/cpython:3.13.18-opt /opt/pyperformance/bin/pyperformance run -f --affinity="$AFFINITY" --python=/opt/bin/cpython-3.13.18-opt -o /results/cpython-3.13.18-opt.json
docker run --rm -v "$PWD/results:/results" python/cpython:3.13.18-jit /opt/pyperformance/bin/pyperformance run -f --affinity="$AFFINITY" --python=/opt/bin/cpython-3.13.18-jit -o /results/cpython-3.13.18-jit.json
docker run --rm -v "$PWD/results:/results" python/cpython:3.14.10-default /opt/pyperformance/bin/pyperformance run -f --affinity="$AFFINITY" --python=/opt/bin/cpython-3.14.10-default -o /results/cpython-3.14.10-default.json
docker run --rm -v "$PWD/results:/results" python/cpython:3.14.10-opt /opt/pyperformance/bin/pyperformance run -f --affinity="$AFFINITY" --python=/opt/bin/cpython-3.14.10-opt -o /results/cpython-3.14.10-opt.json
docker run --rm -v "$PWD/results:/results" python/cpython:3.14.10-jit /opt/pyperformance/bin/pyperformance run -f --affinity="$AFFINITY" --python=/opt/bin/cpython-3.14.10-jit -o /results/cpython-3.14.10-jit.json
docker run --rm -v "$PWD/results:/results" python/cpython:3.15.2-default /opt/pyperformance/bin/pyperformance run -f --affinity="$AFFINITY" --python=/opt/bin/cpython-3.15.2-default -o /results/cpython-3.15.2-default.json
docker run --rm -v "$PWD/results:/results" python/cpython:3.15.2-opt /opt/pyperformance/bin/pyperformance run -f --affinity="$AFFINITY" --python=/opt/bin/cpython-3.15.2-opt -o /results/cpython-3.15.2-opt.json
docker run --rm -v "$PWD/results:/results" python/cpython:3.15.2-jit /opt/pyperformance/bin/pyperformance run -f --affinity="$AFFINITY" --python=/opt/bin/cpython-3.15.2-jit -o /results/cpython-3.15.2-jit.json
