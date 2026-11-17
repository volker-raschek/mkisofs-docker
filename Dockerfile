FROM docker.io/library/rockylinux:10.3.20261112

ARG MKISOFS_VERSION

RUN yum update --assumeyes && \
    yum install --assumeyes bash bash-completion

RUN if [ -z ${MKISOFS_VERSION+x} ]; then \
      yum install --assumeyes xorriso; \
    else \
      yum install --assumeyes xorriso-${MKISOFS_VERSION}; \
    fi

ENTRYPOINT [ "/usr/bin/mkisofs" ]
