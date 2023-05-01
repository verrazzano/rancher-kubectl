# Copyright (C) 2023, Oracle and/or its affiliates.

FROM ghcr.io/oracle/oraclelinux:7-slim AS build_base
ARG ARCH
ARG KUBERNETES_RELEASE=v1.24.5

RUN pwd
# copy olcne repos needed to install kubectl, istioctl
COPY repos/*.repo /etc/yum.repos.d/

WORKDIR /bin

RUN yum update -y \
    && yum install -y kubectl-1.24.5-1.el7 \
    && yum clean all \
    && chmod +x kubectl

FROM scratch
COPY --from=build_base /bin/kubectl /bin/kubectl
ENTRYPOINT ["/bin/kubectl"]
CMD ["help"]
