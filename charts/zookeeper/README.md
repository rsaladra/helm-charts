# Zookeeper Helm Chart

Apache ZooKeeper is a centralized service for maintaining configuration information, naming, providing distributed synchronization, and providing group services.

## Quick Start

### Prerequisites
- Kubernetes 1.24+
- Helm 3.2.0+
- PV provisioner support in the underlying infrastructure (if persistence is enabled)

### Installation

To install the chart with the release name `my-zookeeper`:

```bash
helm install my-zookeeper ./charts/zookeeper
```

To install with custom values:

```bash
helm install my-zookeeper ./charts/zookeeper -f values.yaml
```

### Getting Started

1. Connect to ZooKeeper from inside the cluster:

```bash
kubectl run zk-client --rm --tty -i --restart='Never' \
    --image zookeeper:latest -- bash

# Inside the pod:
zkCli.sh -server my-zookeeper:2181
```

## Configuration

| Parameter                   | Description                                 | Default                     |
|-----------------------------|---------------------------------------------|-----------------------------|
| `image.registry`            | ZooKeeper image registry                    | `docker.io`                 |
| `image.repository`          | ZooKeeper image repository                  | `zookeeper`                 |
| `image.tag`                 | ZooKeeper image tag                         | `3.9.3@sha256:9980cafbff742c15b339811ae829faa61c69154606ec504223560da9d31acd43`|
| `image.pullPolicy`          | Image pull policy                           | `IfNotPresent`              |
| `replicaCount`              | Number of ZooKeeper nodes                   | `3`                         |
| `service.type`              | Kubernetes service type                     | `ClusterIP`                 |
| `service.port`              | ZooKeeper client port                       | `2181`                      |
| `persistence.enabled`       | Enable persistent storage                   | `true`                      |
| `persistence.size`          | Size of persistent volume                   | `8Gi`                       |
| `persistence.mountPath`     | Mount path for ZooKeeper data               | `/data/zookeeper`           |
| `resources.limits.memory`   | Memory limit                                | `512Mi`                     |
| `resources.requests.cpu`    | CPU request                                 | `100m`                      |
| `resources.requests.memory` | Memory request                              | `256Mi`                     |

See [values.yaml](./values.yaml) for the full list of configurable parameters.

## Upgrading

To upgrade your ZooKeeper installation:

```bash
helm upgrade my-zookeeper ./charts/zookeeper
```

## Uninstalling

To uninstall/delete the ZooKeeper deployment:

```bash
helm delete my-zookeeper
```

## References
- [ZooKeeper Documentation](https://zookeeper.apache.org/doc/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
