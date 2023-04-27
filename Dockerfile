# Copyright (C) 2022, Oracle and/or its affiliates.

FROM ghcr.io/oracle/oraclelinux:7-slim AS builder
ARG ARCH
ARG KUBERNETES_RELEASE=v1.25.7

# copy olcne repos needed to install kubectl, istioctl
COPY --from=build_base /root/go/src/github.com/verrazzano/verrazzano/platform-operator/repos/*.repo /etc/yum.repos.d/

WORKDIR /bin

RUN yum update -y \
    && yum install -y --setopt=install_weak_deps=0 --setopt=tsflags=nodocs kubectl-1.25.7-1.el7  \
    && yum clean all \
    && yum -rf /var/cache/yum /var/lib/rpm/* \
    && chmod +x kubectl

FROM scratch
COPY --from=builder /bin/kubectl /bin/kubectl
ENTRYPOINT ["/bin/kubectl"]
CMD ["help"]
