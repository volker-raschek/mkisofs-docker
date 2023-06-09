FROM docker.io/library/rockylinux:9.2

ARG MKISOFS_VERSION

RUN yum update --assumeyes && \
    yum install --assumeyes bash bash-completion

RUN if [ -z ${MKISOFS_VERSION+x} ]; then \
      yum install --assumeyes xorriso; \
    else \
      yum install --assumeyes xorriso-${MKISOFS_VERSION}; \
    fi

ENTRYPOINT [ "/usr/bin/mkisofs" ]
