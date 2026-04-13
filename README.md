# Docker image with GNU ARM none-eabi toolchain and debugging support

`docker pull parrotrueper/arm32_fw_debug:1.0.0`

This repository builds a Docker image for ARM firmware development and debugging.
It is based on an existing ARM toolchain image and adds debugging support,
Python tooling, and compatibility libraries.

## What this project provides

- Docker image: `arm32_fw_debug:latest`
- Base image: `parrotrueper/arm32_fw_tchain:1.0.0`
- Installed debugging dependencies: `libncurses5`, `libtinfo5`
- Python toolchain support for `pyocd`
- Host helper scripts for build, environment setup, and validation

## What is included

 Name             | Version
 :--              | :--
GNU Arm none eabi | 15.2.1
GoogleTest        | 1.17.0
Gtest-parallel    | cd488bd
clang-format      | 22.1.2
cmake             | 4.3.1
cpplint           | 2.0.2
cppcheck          | 2.17.1
flawfinder        | 2.0.19
gcovr             | 8.6
lizard            | 1.21.3
ninja             | 1.12.1
openocd           | n/a
numpy             | 2.4.4
paho-mqtt         | 2.1.0
pytest            | 9.0.2
pytest-mqtt       | 0.7.0
PyYAML            | 6.0.3
regex             | 2026.3.32
requests          | 2.33.1
openpyxl          | 3.1.5
pyocd             | 0.44.0
shellcheck        | 0.11.0
shfmt             | 3.8.0
ssh               | 10.0p2
tar               | 1.35
wget              | 1.25.0
libncurses5       | 6.4-4
libtinfo5         | 6.4-4
st-util           | v1.8.0
PC-Lint           | installed - requires license

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
