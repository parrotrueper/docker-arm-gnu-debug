#!/usr/bin/env bash
# Exit on error
set -euo pipefail

# shellcheck source=/dev/null
. ci/functions.sh

if [[ -f /.dockerenv ]]; then
    warn "$0 needs to be run on host"
    fatal 1 "You need to be outside a docker container to run this script"
fi

# shellcheck source=/dev/null
. .env

info "Pulling base image"
# try and pull the base image, if that fails then we need to build it
if ! docker pull "${BASE_IMAGE:?}"; then
    info "Base image not found on registry, building locally"

    run mkdir -p "${clone_dir:?}"

    run pushd "${clone_dir}"
        if [[ ! -d "${git_repo_name:?}" ]]; then
            run git clone "${git_url_cli:?}/${git_repo_name:?}.git"
        fi
        run cd "${git_repo_name:?}"
        run git checkout "${git_branch:?}"
        info "checking for upstream changes"
        run git pull

        # shellcheck source=/dev/null
        . .env

        info "building docker image: ${RESULT_IMAGE:?}"
        run "${build_script:?}"
        run docker image tag "${RESULT_IMAGE:?}" "${HUB_TAG:?}:${VERSION_TAG:?}"
    run popd || exit 1
fi

