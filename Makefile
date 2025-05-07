# MKISOFS_VERSION
# Only required to install a specify version
MKISOFS_VERSION?=1.5.4

# CONTAINER_RUNTIME
# The CONTAINER_RUNTIME variable will be used to specified the path to a
# container runtime. This is needed to start and run a container image.
CONTAINER_RUNTIME?=$(shell which podman)

# MKISOFS_IMAGE_REGISTRY_NAME
# Defines the name of the new container to be built using several variables.
MKISOFS_IMAGE_REGISTRY_NAME?=git.cryptic.systems
MKISOFS_IMAGE_REGISTRY_USER?=volker.raschek

MKISOFS_IMAGE_NAMESPACE?=${MKISOFS_IMAGE_REGISTRY_USER}
MKISOFS_IMAGE_NAME:=mkisofs
MKISOFS_IMAGE_VERSION?=latest
MKISOFS_IMAGE_FULLY_QUALIFIED=${MKISOFS_IMAGE_REGISTRY_NAME}/${MKISOFS_IMAGE_NAMESPACE}/${MKISOFS_IMAGE_NAME}:${MKISOFS_IMAGE_VERSION}
MKISOFS_IMAGE_UNQUALIFIED=${MKISOFS_IMAGE_NAMESPACE}/${MKISOFS_IMAGE_NAME}:${MKISOFS_IMAGE_VERSION}

# BUILD CONTAINER IMAGE
# ==============================================================================
PHONY:=container-image/build
container-image/build:
	${CONTAINER_RUNTIME} build \
		--build-arg MKISOFS_VERSION=${MKISOFS_VERSION} \
		--file Dockerfile \
		--no-cache \
		--pull \
		--tag ${MKISOFS_IMAGE_FULLY_QUALIFIED} \
		--tag ${MKISOFS_IMAGE_UNQUALIFIED} \
		.

# DELETE CONTAINER IMAGE
# ==============================================================================
PHONY:=container-image/delete
container-image/delete:
	- ${CONTAINER_RUNTIME} image rm ${MKISOFS_IMAGE_FULLY_QUALIFIED} ${MKISOFS_IMAGE_UNQUALIFIED}
	- ${CONTAINER_RUNTIME} image rm ${BASE_IMAGE_FULL}

# PUSH CONTAINER IMAGE
# ==============================================================================
PHONY+=container-image/push
container-image/push:
	echo ${MKISOFS_IMAGE_REGISTRY_PASSWORD} | ${CONTAINER_RUNTIME} login ${MKISOFS_IMAGE_REGISTRY_NAME} --username ${MKISOFS_IMAGE_REGISTRY_USER} --password-stdin
	${CONTAINER_RUNTIME} push ${MKISOFS_IMAGE_FULLY_QUALIFIED}

# PHONY
# ==============================================================================
# Declare the contents of the PHONY variable as phony.  We keep that information
# in a variable so we can use it in if_changed.
.PHONY: ${PHONY}
