#!/usr/bin/env bash
# Exit on error
set -euo pipefail

# shellcheck source=/dev/null
. ci/functions.sh

run rm -rf unit-tests/blinky/build
run rm -rf unit-tests/blinky/.mxproject
run rm -rf unit-tests/blinky/blinky.hex
run rm -rf unit-tests/documentation
run rm -rf unit-tests/reports
run rm -rf unit-tests/modules/template/test/build
run rm -rf doxygen.log
