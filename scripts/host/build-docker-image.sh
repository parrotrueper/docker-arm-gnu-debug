#!/usr/bin/env bash
# Exit on error
set -euo pipefail

#-------------------------------------------
# Run the test harness. Invoke as "ci/test".
#-------------------------------------------

# shellcheck source=/dev/null
. ci/functions.sh

# shellcheck source=/dev/null
source .env

bld_cmd="docker build"

if [[ "${VERBOSE:?}" == "yes" ]]; then
	bld_cmd+=" --progress=plain"
fi

if [[ "${USE_CACHE:?}" == "no" ]]; then
	bld_cmd+=" --no-cache"
fi
bld_cmd+=" -f ${DBG_FILE:?}"
bld_cmd+=" -t ${DBG_RESULT_IMAGE:?}"
# build context
bld_cmd+=" ${DBG_CONTEXT:?}"

#echo "${bld_cmd}"
eval "${bld_cmd}"

