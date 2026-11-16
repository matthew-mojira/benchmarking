#!/bin/bash
set -euo pipefail

CPU_PAIRS=(0-1 2-3 4-5 6-7 8-9 10-11 12-13 14-15)

BUILDS=(
  cpython-3.10.22-default
  cpython-3.10.22-opt
  cpython-3.11.18-default
  cpython-3.11.18-opt
  cpython-3.12.16-default
  cpython-3.12.16-opt
  cpython-3.13.18-default
  cpython-3.13.18-opt
  cpython-3.13.18-jit
  cpython-3.14.10-default
  cpython-3.14.10-opt
  cpython-3.14.10-jit
  cpython-3.15.2-default
  cpython-3.15.2-opt
  cpython-3.15.2-jit
)

mkdir -p results

free_slots=("${!CPU_PAIRS[@]}")
declare -A slot_of_pid

for build in "${BUILDS[@]}"; do
  if [ ${#free_slots[@]} -eq 0 ]; then
    wait -n -p done_pid || true
    free_slots+=("${slot_of_pid[$done_pid]}")
    unset "slot_of_pid[$done_pid]"
  fi
  slot=${free_slots[0]}
  free_slots=("${free_slots[@]:1}")

  docker run --rm --cpuset-cpus "${CPU_PAIRS[$slot]}" -v "$PWD/results:/results" "python/cpython:${build#cpython-}" \
    /opt/pyperformance/bin/pyperformance run -f --python="/opt/bin/$build" -o "/results/$build.json" \
    > "results/$build.log" 2>&1 < /dev/null &
  slot_of_pid[$!]=$slot
done

wait
