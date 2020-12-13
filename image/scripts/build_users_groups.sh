#!/bin/bash

set -e

source /hbb_build/scripts/common.sh

if ! eval_bool "$SKIP_USERS_GROUPS"; then
    run groupadd -g 9327 builder
    run adduser --uid 9327 --gid 9327 builder
fi
