#!/usr/bin/env bash
set -euo pipefail

runtime_dir="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"

tty=()
[ -t 0 ] && tty=(-t)

docker run --rm -i "${tty[@]}" \
  --volume="${runtime_dir}/pulse/native:/tmp/pulse/native:ro" \
  pulseaudio:26.04 \
  "$@"
