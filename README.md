# Docker image with GNU ARM none-eabi toolchain and debugging support

`docker pull parrotrueper/arm32_fw_debug:1.1.0`

This repository builds a Docker image for ARM firmware development and debugging.
It is based on an existing ARM toolchain image and adds debugging support,
Python and Rust tooling, and compatibility libraries.

## What this project provides

- Docker image: `arm32_fw_debug:latest`
- Base image: `parrotrueper/arm32_fw_tchain:1.0.0`
- Installed debugging dependencies: `libncurses5`, `libtinfo5`
- Python toolchain support for `pyocd`
- Host helper scripts for build, environment setup, and validation

## What is included

 Name             | Version
 :--              | :--
arm-none-eabi-gcc | 15.2.1
build-essential   | 12.12
cargo             | 1.95.0
ccze              | 0.2.1
clang-format      | 22.1.2
cmake             | 4.3.1
cpplint           | 2.0.2
cppcheck          | 2.17.1
curl              | 8.14.1
doctest           | 0.22.6
doxygen           | 1.9.8
flawfinder        | 2.0.19
gcovr             | 8.6
git               | 2.47.3
graphviz          | 2.42.4
FuzzTest          | b73724d
GoogleTest        | 52eb8108
Gtest-parallel    | cd488bd
lcov              | 2.0-1
libncurses5       | 6.4-4
libtinfo5         | 6.4-4
lizard            | 1.21.3
ninja             | 1.12.1
nlohmann-json     | 3.11.3
numpy             | 2.4.4
openocd           | 0.12.0
openpyxl          | 3.1.5
paho-mqtt         | 2.1.0
PC-Lint           | 2025 SP1
pytest            | 9.0.2
pytest-mqtt       | 0.7.0
PyYAML            | 6.0.3
regex             | 2026.3.32
requests          | 2.33.1
pyocd             | 0.44.0
rust              | 1.95.0
shellcheck        | 0.11.0
shfmt             | 3.8.0
ssh               | 10.0p2
st-util           | 1.8.0
tar               | 1.35
wget              | 1.25.0
zip               | 3.0

## Build instructions

Prerequisites:

- Docker Engine
- `jq`

To build the Docker image locally:

```bash
./scripts/build
```

This script will:

1. Generate `.env` from `config.json`
2. Pull the configured base image or build it if not available
3. Build the final `arm32_fw_debug:latest` image

## Run the container

To start a shell in the built image with the current repository mounted at `/workspace`:

```bash
./scripts/run-container
```

### PC Lint

For PC-Lint you need a valid license to include it in your image

Dockerfile-pclint

```shell
FROM parrotrueper/arm32_fw_debug:latest

COPY ./your-license-file.lic /opt/pclp/
```
