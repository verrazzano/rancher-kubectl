# Copyright (C) 2022, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

FROM ghcr.io/oracle/oraclelinux:8-slim AS builder
ARG ARCH
ARG KUBERNETES_RELEASE=v1.17.0
WORKDIR /bin
RUN set -x \
 && curl -fsSLO https://storage.googleapis.com/kubernetes-release/release/${KUBERNETES_RELEASE}/bin/linux/${ARCH}/kubectl \
 && chmod +x kubectl

FROM ghcr.io/oracle/oraclelinux:8-slim
COPY --from=builder /bin/kubectl /bin/kubectl
ENTRYPOINT ["/bin/kubectl"]
CMD ["help"]
