#!/bin/bash

source /hbb_build/functions.sh
source /hbb_build/activate_func.sh

run mkdir -p /hbb /hbb/bin
run cp /hbb_build/libcheck /hbb/bin/
run cp /hbb_build/hardening-check /hbb/bin/
run cp /hbb_build/setuser /hbb/bin/
run cp /hbb_build/activate_func.sh /hbb/activate_func.sh
run cp /hbb_build/hbb-activate /hbb/activate
run cp /hbb_build/activate-exec /hbb/activate-exec
