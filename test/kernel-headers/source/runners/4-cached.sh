#!/bin/bash
# Copyright The OpenTelemetry Authors
# SPDX-License-Identifier: Apache-2.0

EBPF_NET_SRC_ROOT="${EBPF_NET_SRC_ROOT:-$(git rev-parse --show-toplevel)}"
source "${EBPF_NET_SRC_ROOT}/dev/script/bash-error-lib.sh"
set -x

if [ $# -eq 1 ]
then
    vagrant ssh -- -R "5000:localhost:5000" -- ./agent.sh $1
elif [ $# -eq 0 ]    
then
    vagrant ssh -- -R "5000:localhost:5000" -- ./agent.sh      
fi




