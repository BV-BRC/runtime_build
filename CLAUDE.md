# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

BV-BRC Runtime Build System — orchestrates compilation and installation of 240+ bioinformatics and computational biology tools into unified runtime environments. Produces Singularity/Apptainer container images and optional RPM packages.

## Build Commands

### Module-based build (main workflow)
```bash
# Build a set of modules into a target directory
./bootstrap_modules.pl -d /kb/runtime -m modules-patric3-core.dat

# With build dependency installation (CentOS/RHEL only)
./bootstrap_modules.pl -d /kb/runtime -m modules-patric3-core.dat --install-build-dependencies

# Continue after failure (skip already-built modules via marker files)
./bootstrap_modules.pl -d /kb/runtime -m modules-patric3-core.dat --fail-ok

# Add extra paths to PATH during build
./bootstrap_modules.pl -d /kb/runtime -m modules-patric3-core.dat --path /extra/bin
```

### Container builds (Ubuntu 22)
```bash
cd ubuntu-22
./build-runtime <output-base>   # Produces <output-base>-base.sif, then stages
```

### GPU container builds (CUDA 12.2 + cuDNN 8.9.6)
```bash
cd gpu-builds/cuda-12.2-cudnn-8.9.6
../build-containers <dest-dir> <build-idx>   # Uses apptainer build
```

### Tests
```bash
/kb/runtime/bin/perl t/perl-modules.t   # Validate Perl module installation
```

## Architecture

### Build orchestration

`bootstrap_modules.pl` is the central build script. It:
1. Reads a `.dat` module list specifying `<module-dir> <build-command>` pairs
2. Detects the OS distro (Ubuntu/CentOS/RHEL) to select package manager and skip rules
3. Sets `TARGET`, `PATH`, `CPATH`, `LIBRARY_PATH` environment variables
4. Executes each module's build script sequentially from `runtime-modules/<dir>/`
5. Logs output to `logs.<dat-basename>/` and writes `built.<tag>` marker files for resumability
6. Writes `$dest/VERSION` from `git describe` on completion

### Module .dat file format

Lines are `<module-dir> <build-command>`. Metadata lines start with `##`:
- `## rpm-name`, `## rpm-version` — RPM packaging metadata
- `## rpm-build-dep`, `## rpm-dep` — build/runtime dependencies
- `## os-skip <distro>` — skip module on named OS
- Single `#` lines with `<key> <value>` set per-module environment variables

### runtime-modules/

Each subdirectory is a self-contained module with its own build script (typically `build.package`, `build.runtime`, or `install-*.sh`). Build scripts receive `$TARGET` as the install destination. OS-specific variants use directory suffixes: `_ubuntu`, `_centos`, `_rhel`, `_mac`.

### Container system

- `ubuntu-22/` — Singularity `.def` files for multi-stage container builds (base image, then finish stages layering in the runtime)
- `gpu-builds/` — Apptainer `.def` files for CUDA-enabled containers (AlphaFold, Chai, Boltz, DiffDock)
- `gpu-builds/add-packages.def` and `add-runtime.def` — reusable templates for injecting packages/runtime into GPU containers

### Module categories (prefix conventions)

- `kb_*` — KBase-era foundational runtimes (Perl, Python, Java, Go, curl, git)
- `p3_*` — PATRIC/BV-BRC bioinformatics tools (BLAST, BWA, samtools, RAxML, SPAdes, etc.)
- `cepi_*` — CEPI ML/structural biology tools (ProteinMPNN, ThermoMPNN)

### Key environment variables during build

| Variable | Purpose |
|---|---|
| `TARGET` | Destination directory (e.g., `/kb/runtime`) |
| `PATH` | Prepended with `$TARGET/bin` |
| `CPATH` | Set to `$TARGET/include` |
| `LIBRARY_PATH` | Set to `$TARGET/lib` |

### tools/error_handler

Bash function (`error()`) sourced by build scripts for consistent error reporting with line numbers.
