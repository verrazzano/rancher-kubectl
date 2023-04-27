# Copyright (C) 2023, Oracle and/or its affiliates.

FROM ghcr.io/oracle/oraclelinux:7-slim AS builder
ARG ARCH
ARG KUBERNETES_RELEASE=v1.25.7

RUN pwd
# copy olcne repos needed to install kubectl, istioctl
COPY --from=builder repos/*.repo /etc/yum.repos.d/

WORKDIR /bin

RUN yum-config-manager --enable ol7_optional_latest && \
    yum-config-manager --enable ol7_addons && \
    yum update -y && \
    && yum install -y --setopt=install_weak_deps=0 --setopt=tsflags=nodocs kubectl-1.25.7-1.el7 && \
    && yum clean all && \
    && yum -rf /var/cache/yum /var/lib/rpm/* && \
    && chmod +x kubectl

FROM scratch
COPY --from=builder /bin/kubectl /bin/kubectl
ENTRYPOINT ["/bin/kubectl"]
CMD ["help"]
