# mkisofs-docker

[![Docker Pulls](https://img.shields.io/docker/pulls/volkerraschek/mkisofs)](https://hub.docker.com/r/volkerraschek/mkisofs)

This project contains all sources to build the container image
`docker.io/volkerraschek/mkisofs` and the shell script `mkisofs.sh`.

The primary goal of this project is to package the binary `mkisofs` and
dependencies as container image to provide the functionally for CI/CD workflows
or for systems which does contains the binary.

## Usage

The script forwards all arguments directly to the binary running inside the
container. For this reason, all arguments from the original binary can be used,
for example to create an adapted bootable fedora iso image.

```bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

podman run \
  --rm \
  --volume ${SCRIPT_DIR}:/workspace \
  --workdir /workspace \
  docker.io/volkerraschek/mkisofs \
    -output /workspace/fedora-35.iso \
    -eltorito-boot isolinux/isolinux.bin \
    -eltorito-catalog isolinux/boot.cat \
    -no-emul-boot \
    -joliet \
    -joliet-long \
    -boot-load-size 4 \
    -boot-info-table \
    -full-iso9660-filenames \
    -rational-rock \
    -verbose \
    -volid "exam" \ # specified in ks.cfg
    /workspace/custom-iso
```
