<p align="center">
    <a href="https://artifacthub.io/packages/search?repo=cloudpirates-ghost"><img src="https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/cloudpirates-ghost" /></a>
</p>


# Ghost Helm Chart

Ghost is a simple, powerful publishing platform for creating blogs and online publications. This Helm chart deploys Ghost on Kubernetes with optional MariaDB support.


## Installation

To install the chart with the release name `my-ghost`:

```bash
helm install my-ghost oci://registry-1.docker.io/cloudpirates/ghost
```

To install with custom values:

```bash
helm install my-ghost oci://registry-1.docker.io/cloudpirates/ghost -f my-values.yaml
```


## Uninstalling

To uninstall/delete the `my-ghost` deployment:

```bash
helm uninstall my-ghost
```


## Security & Signature Verification

This Helm chart is cryptographically signed with Cosign to ensure authenticity and prevent tampering.

**Public Key:**

```
-----BEGIN PUBLIC KEY-----
MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAE7BgqFgKdPtHdXz6OfYBklYwJgGWQ
mZzYz8qJ9r6QhF3NxK8rD2oG7Bk6nHJz7qWXhQoU2JvJdI3Zx9HGpLfKvw==
-----END PUBLIC KEY-----
```

To verify the helm chart before installation, copy the public key to the file `cosign.pub` and run cosign:

```bash
cosign verify --key cosign.pub registry-1.docker.io/cloudpirates/ghost:<version>
```


## Configuration

The following table lists the configurable parameters of the Ghost chart and their default values (see `values.yaml` for full details):

| Parameter                | Description                                 | Default         |
|--------------------------|---------------------------------------------|-----------------|
| `image.repository`       | Ghost image repository                      | `ghost`         |
| `image.tag`              | Ghost image tag                             | `6.0.9`         |
| `containerPorts`         | List of container ports                     | `[{name: http, containerPort: 2368}]` |
| `service.type`           | Kubernetes service type                     | `ClusterIP`     |
| `service.ports`          | List of service ports                       | `[{port: 80, targetPort: http}]` |
| `ingress.enabled`        | Enable ingress                              | `true`          |
| `ingress.hosts`          | List of ingress hosts                       | `ghost.localhost`|
| `persistence.enabled`    | Enable persistence (PVC)                    | `true`          |
| `resources`              | Pod resource requests/limits                | `{}`            |
| `mariadb.enabled`        | Deploy MariaDB as dependency                | `true`          |
| `config`                 | Ghost configuration (database, mail, etc.)  | See values.yaml |


## Example: Custom Ghost Configuration

Create a `my-values.yaml` file to override default settings:

https://docs.ghost.org/config 

```yaml
config:
  database:
    client: "mysql"
    connection:
      host: "ghost-mariadb"
      port: 3306
      user: "ghost"
      password: "changeme"
      database: "ghost"
    pool:
      min: 2
      max: 10
  mail:
    transport: "SMTP"
    options:
      service: "Mailgun"
      host: "smtp.mailgun.org"
      port: 465
      secure: true
      auth:
        user: "postmaster@example.mailgun.org"
        pass: "1234567890"
    from: "support@example.com"
  server:
    host: "0.0.0.0"
    port: 2368
  privacy:
    useUpdateCheck: false
    useGravatar: false
    useRpcPing: false
    useStructuredData: false
  security:
    staffDeviceVerification: false
  paths:
    contentPath: "content/"
  referrerPolicy: "origin-when-crossorigin"
  logging:
    path: "content/logs/"
    useLocalTime: true
    level: "info"
    rotation:
      enabled: true
      count: 10
      period: "1d"
    transports:
      - "stdout"
      - "file"
  caching:
    frontend:
      maxAge: 0
    contentAPI:
      maxAge: 10
    robotstxt:
      maxAge: 3600
    sitemap:
      maxAge: 3600
    sitemapXSL:
      maxAge: 86400
    wellKnown:
      maxAge: 86400
    cors:
      maxAge: 86400
    publicAssets:
      maxAge: 31536000
    threeHundredOne:
      maxAge: 31536000
    customRedirects:
      maxAge: 31536000
  compress: true
  imageOptimization:
    resize: false
  storage:
    active: "local-file-store"
  adapters:
    cache:
      imageSizes:
        adapter: "Redis"
        ttl: 3600
        keyPrefix: "image-sizes:"
  portal:
    url: "https://cdn.jsdelivr.net/npm/@tryghost/portal@~{version}/umd/portal.min.js"
  sodoSearch:
    url: "https://cdn.jsdelivr.net/npm/@tryghost/sodo-search@~{version}/umd/sodo-search.min.js"
    styles: "https://cdn.jsdelivr.net/npm/@tryghost/sodo-search@~{version}/umd/main.css"
  comments:
    url: "https://cdn.jsdelivr.net/npm/@tryghost/comments-ui@~{version}/umd/comments-ui.min.js"
    styles: "https://cdn.jsdelivr.net/npm/@tryghost/comments-ui@~{version}/umd/main.css"
```

Install with:
```bash
helm install my-ghost oci://registry-1.docker.io/cloudpirates/ghost -f my-values.yaml
```


## Troubleshooting

### Connection Issues

1. **Check deployment and service status**:
  ```bash
  kubectl get deployment -l app.kubernetes.io/name=ghost
  kubectl get svc -l app.kubernetes.io/name=ghost
  kubectl get pods -l app.kubernetes.io/name=ghost
  ```
2. **Check pod logs**:
  ```bash
  kubectl logs <pod-name>
  ```

### Database Issues

- Ensure MariaDB is running and accessible if using the bundled database.
- Check database credentials in your values file.

### Performance Tuning

- Adjust resources in `values.yaml` for production workloads.
- Use persistent storage for content.
- Monitor pod health and logs for errors.


## Useful Links

- [Ghost Documentation](https://ghost.org/docs/)
- [Ghost Docker Hub](https://hub.docker.com/_/ghost)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
