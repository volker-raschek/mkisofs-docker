# mkisofs-docker

[![Build Status](https://drone.cryptic.systems/api/badges/volker.raschek/mkisofs-docker/status.svg)](https://drone.cryptic.systems/volker.raschek/mkisofs-docker)
[![Docker Pulls](https://img.shields.io/docker/pulls/volkerraschek/mkisofs)](https://hub.docker.com/r/volkerraschek/mkisofs)

This project contains all sources to build the container image
`docker.io/volkerraschek/mkisofs` and the shell script `mkisofs.sh`.

The primary goal of this project is to package the binary `mkisofs` and
dependencies as container image to provide the functionally for CI/CD workflows
or for systems which does contains the binary.

## mkisofs.sh

The shell script `mkisofs.sh` is a wrapper for the binary `mkisofs`, which
is not available depending on the distribution. It starts the container image
`docker.io/volkerraschek/mkisofs` in the background to call the binary. For
this reason, a container runtime like `docker` or `podman` is necessary.

### Installation

The script can be installed via the following command:

```bash
curl https://git.cryptic.systems/volker.raschek/mkisofs-docker/raw/branch/master/mkisofs.sh --output - | sudo tee /usr/local/bin/mkisofs.sh && sudo chmod +x /usr/local/bin/mkisofs.sh
```

### Usage

The script forwards all arguments directly to the binary running inside the
container. For this reason, all arguments from the original binary can be used.
