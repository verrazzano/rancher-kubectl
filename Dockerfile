FROM ghcr.io/oracle/oraclelinux:7-slim AS builder
ARG ARCH
ARG KUBERNETES_RELEASE=v1.17.0
WORKDIR /bin
RUN set -x \
 && curl -fsSLO https://storage.googleapis.com/kubernetes-release/release/${KUBERNETES_RELEASE}/bin/linux/${ARCH}/kubectl \
 && chmod +x kubectl

FROM ghcr.io/oracle/oraclelinux:7-slim
COPY --from=builder /bin/kubectl /bin/kubectl
ENTRYPOINT ["/bin/kubectl"]
CMD ["help"]
