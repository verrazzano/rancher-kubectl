# Build Instructions

The base tag this release is branched from is `v1.20.2`

Create Environment Variables

```
export DOCKER_REPO=<Docker Repository>
export DOCKER_NAMESPACE=<Docker Namespace>
export DOCKER_TAG=v1.24.5-BFS
```

Build and Push Images

```
# Build and push rancher-webhook
docker build --build-arg ARCH=amd64 --tag rancher/kubectl:v1.24.5 .

docker tag rancher/kubectl:v1.24.5 ${DOCKER_REPO}/${DOCKER_NAMESPACE}/kubectl:${DOCKER_TAG}
docker push ${DOCKER_REPO}/${DOCKER_NAMESPACE}/kubectl:${DOCKER_TAG}
```
