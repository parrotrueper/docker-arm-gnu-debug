# ARM Release Note extract

[Full release note can be found here](https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads)

As of Release 15.2.Rel1, all toolchains (Linux, Windows, and macOS) now include
two GDB executables. GDB with Python scripting support was newly added for
Windows and macOS in this release.

    GDB with Python scripting support, identified by the "-py" suffix. Details
    for Python-enabled GDB builds:
        Linux: built with Python 3.8.20
    GDB without Python support, which does not include the "-py" suffix.

---

GDB can be used with Python support or without Python support. To use GDB with
Python support, Python 3.8 is required to be installed, and on Ubuntu 20.04 or
later you might also need to install `libncurses5` or `libncursesw5`. You might
need to install `Python 3.8` from source. The information about installing
Python can be found from other sources or websites, unaffiliated to Arm, for
example, from docs.python.org, or from LinuxCapable. For GDB to be able to
detect the existence of an installed Python 3.8 library on the system, you might
also need to set the `PYTHONPATH` and `PYTHONHOME` environment variables. Set
`PYTHONHOME` to the location where the Python 3.8 libraries are. For example, if
`Python 3.8` was installed to `/usr/lib` or `/usr/lib64`, then set
`PYTHONHOME=/usr`. In order to find the correct value for `PYTHONPATH`, run
`python3.8 -c "import sys; print(sys.path)"` and look for the path ending in
`/python3.8. Set PYTHONPATH=<that path ending in /python3.8>`

---

A software GDB server is required for GDB to communicate with CMSIS-DAP based
hardware debugger. The pyOCD is an implementation of such GDB server that is
written in Python and under Apache License.

For those who are using this toolchain and have a board with CMSIS-DAP based
debugger, the pyOCD is our recommended gdb server. More information can be
found at `https://github.com/pyocd/pyOCD.`

## Regarding ncurses

The Docker base image we use for firmware development is debian trixie and
libncurses5 is not available for this version as it has now been superseeded by
libncurses6 which doesn't seem to work with the ARM GDB.

Instead we use ncurses for debian bookworm which is the previous release
[libncurses5](https://packages.debian.org/bookworm/libncurses5)
and its dependency [libtinfo5](https://packages.debian.org/bookworm/libtinfo5)

| package | MD5 checksum |
| -- | -- |
| libncurses5_6.4-4_amd64.deb | 69509717d23e24e005afb5d99c1ace32 |
| libtinfo5_6.4-4_amd64.deb | bb47d297100caabef7f3c305202fbb06 |
