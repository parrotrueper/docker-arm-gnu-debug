#!/usr/bin/env bash
# Exit on error
set -euo pipefail

IMAGE="${1:-}"
if [[ -f .env ]]; then
  # shellcheck source=/dev/null
  source .env
fi
IMAGE="${IMAGE:-${DBG_RESULT_IMAGE:-arm32_fw_tchain:latest}}"

usage() {
  cat <<EOF
Usage: $0 [docker-image]

Query versions for the applications listed in README.md from a built Docker image.
If no image is provided, the script uses ".env" DBG_RESULT_IMAGE or defaults to
arm32_fw_debug:latest.
EOF
}

if [[ "${IMAGE:-}" == "" || "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
  usage
  exit 0
fi

if ! docker image inspect "${IMAGE}" >/dev/null 2>&1; then
  echo "ERROR: Docker image '${IMAGE}' not found locally." >&2
  echo "Build the image first or pass a valid image tag." >&2
  exit 1
fi

run_in_image() {
  docker run --rm "${IMAGE}" bash -lc "$*"
}

fetch() {
  local name="$1"
  local cmd="$2"
  printf "%-16s : " "${name}"
  #shellcheck disable=SC2310
  if output=$(run_in_image "${cmd}" 2>/dev/null); then
    if [[ -n "${output//[$'\t\n\r ']}" ]]; then
      echo "${output//$'\n'/\n                }"
    else
      echo "n/a"
    fi
  else
    echo "missing"
  fi
}

fetch_python_pkg() {
  local name="$1"
  local module="$2"
  fetch "${name}" "python -c 'import importlib, sys; m=importlib.import_module(\"${module}\"); print(getattr(m, \"__version__\", getattr(m, \"VERSION\", \"unknown\")))'"
}

printf "Checking versions in Docker image: %s\n\n" "${IMAGE}"

fetch "arm-none-eabi-gcc" "/opt/gcc-arm-none-eabi/bin/arm-none-eabi-gcc --version | head -n1 | sed -E 's/.* ([0-9]+(\.[0-9]+)+) .*/\1/'"
fetch "GoogleTest" "[[ -d /opt/googletest ]] && cd /opt/googletest && git rev-parse --short HEAD || echo 'missing'"
fetch "Gtest-parallel" "[[ -d /opt/gtest-parallel ]] && cd /opt/gtest-parallel && git rev-parse --short HEAD || echo 'missing'"
fetch "clang-format" "command -v clang-format >/dev/null && clang-format --version | head -n1 | sed -E 's/^[^0-9]*([0-9]+([.][0-9A-Za-z_-]+)*).*$/\1/'"
fetch "cmake" "cmake --version | head -n1 | sed -E 's/^[^0-9]*([0-9]+([.][0-9A-Za-z_-]+)*).*$/\1/'"
fetch "cpplint" "python -m pip show cpplint 2>/dev/null | awk -F': ' '/^Version:/{print \$2}'"
fetch "cppcheck" "cppcheck --version | head -n1 | sed -E 's/^[^0-9]*([0-9]+([.][0-9A-Za-z_-]+)*).*$/\1/'"
fetch "flawfinder" "flawfinder --version | head -n1 | sed -E 's/^[^0-9]*([0-9]+([.][0-9A-Za-z_-]+)*).*$/\1/'"
fetch "gcovr" "gcovr --version | head -n1 | sed -E 's/^[^0-9]*([0-9]+([.][0-9A-Za-z_-]+)*).*$/\1/'"
fetch "lizard" "lizard --version | head -n1 | sed -E 's/^[^0-9]*([0-9]+([.][0-9A-Za-z_-]+)*).*$/\1/'"
fetch "ninja" "ninja --version | head -n1 | sed -E 's/^[^0-9]*([0-9]+([.][0-9A-Za-z_-]+)*).*$/\1/'"
fetch "openocd" "openocd --version 2>&1 | head -n1 | sed -n 's/^Open On-Chip Debugger //p'"
fetch_python_pkg "numpy" "numpy"
fetch_python_pkg "paho-mqtt" "paho.mqtt"
fetch "pytest" "pytest --version | head -n1 | sed -E 's/^[^0-9]*([0-9]+([.][0-9A-Za-z_-]+)*).*$/\1/'"
fetch_python_pkg "pytest-mqtt" "pytest_mqtt"
fetch_python_pkg "PyYAML" "yaml"
fetch_python_pkg "regex" "regex"
fetch_python_pkg "requests" "requests"
fetch_python_pkg "openpyxl" "openpyxl"
fetch "pyocd" "pyocd --version | head -n1 | sed -E 's/^[^0-9]*([0-9]+([.][0-9A-Za-z_-]+)*).*$/\1/'"
fetch "shellcheck" "shellcheck --version 2>/dev/null | awk -F': ' '/^version:/{print \$2}'"
fetch "shfmt" "shfmt --version | head -n1 | sed -E 's/^[^0-9]*([0-9]+([.][0-9A-Za-z_-]+)*).*$/\1/'"
fetch "ssh" "ssh -V 2>&1 | sed -nE 's/^OpenSSH_([0-9]+([.][0-9A-Za-z_-]+)*).*$/\1/p'"
fetch "tar" "tar --version 2>/dev/null | head -n1 | sed -E 's/^[^0-9]*([0-9]+([.][0-9A-Za-z_-]+)*).*$/\1/'"
fetch "wget" "wget --version 2>/dev/null | head -n1 | sed -E 's/^[^0-9]*([0-9]+([.][0-9A-Za-z_-]+)*).*$/\1/'"
fetch "libncurses5" "dpkg-query -W -f='\${Version}\\n' libncurses5 libncurses6 2>/dev/null | head -n1 || true"
fetch "libtinfo5" "dpkg-query -W -f='\${Version}\\n' libtinfo5 libtinfo6 2>/dev/null | head -n1 || true"
fetch "st-util" "st-util --version | head -n1 | sed -E 's/^[^0-9]*([0-9]+([.][0-9A-Za-z_-]+)*).*$/\1/'"
fetch "PC-Lint" "[[ -d /opt/pclp ]] && echo 'installed' || echo 'missing'"

printf "\nNote: some package versions are obtained from command output, others from Python package metadata.\n"
