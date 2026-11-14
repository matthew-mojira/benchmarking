#!/bin/bash
set -euo pipefail

version=$1
only_config=$2
versions=${3:-versions/cpython.tsv}
src=/tmp/cpython

build_cpython() {
  local version=$1
  local commit=$2
  local build_configs=$3

  git -C "$src" checkout --quiet --force "$commit"

  IFS=, read -r -a configs <<< "$build_configs"
  for config in "${configs[@]}"; do
    local -a configure_flags
    if [ "$config" = default ]; then
      configure_flags=()
    elif [ "$config" = opt ]; then
      configure_flags=(--enable-optimizations)
    elif [ "$config" = jit ]; then
      configure_flags=(--enable-experimental-jit)
    else
      echo "unknown build config: $config" >&2
      exit 1
    fi

    local build=/tmp/build-$version-$config
    mkdir "$build"
    cd "$build"

    "$src/configure" --prefix="/opt/cpython/$version-$config" "${configure_flags[@]}"
    make -j"$(nproc)"
    make install
    mkdir -p /opt/bin
    ln -s "/opt/cpython/$version-$config/bin/python3" "/opt/bin/cpython-$version-$config"

    make distclean
  done
}

commit=
build_configs=
while IFS=$'\t' read -r row_version row_commit row_configs; do
  if [ "$row_version" = "$version" ]; then
    commit=$row_commit
    build_configs=$row_configs
    break
  fi
done < <(tail -n +2 "$versions")

if [ -z "$commit" ]; then
  echo "no row for version $version in $versions" >&2
  exit 1
fi

if [[ ",$build_configs," != *",$only_config,"* ]]; then
  echo "config $only_config is not listed for version $version in $versions" >&2
  exit 1
fi
build_configs=$only_config

git clone --filter=blob:none --no-checkout https://github.com/python/cpython "$src"
build_cpython "$version" "$commit" "$build_configs"

rm -rf "$src"
