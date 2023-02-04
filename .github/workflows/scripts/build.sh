#!/bin/bash
# Copyright The OpenTelemetry Authors
# SPDX-License-Identifier: Apache-2.0

docker run -t \
  --rm \
  --mount "type=bind,source=/var/run/docker.sock,destination=/var/run/docker.sock" \
  --mount "type=bind,source=$(git rev-parse --show-toplevel),destination=/root/src,readonly" \
  --env EBPF_NET_SRC=/root/src \
  --env EBPF_NET_OUT_DIR=/root/out \
  --workdir=/root/out \
  build-env \
    ../build.sh docker
