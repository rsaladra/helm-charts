# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2025-01-16

### Added

- Initial Keycloak Helm chart implementation
- Support for Keycloak 26.3.4 container image
- Comprehensive configuration options for Keycloak server
- Database support for H2, PostgreSQL, MySQL, and MariaDB
- Ingress configuration with TLS support
- Persistent volume support for data storage
- Security contexts and service account configuration
- Configurable cache settings (local, ispn, default)
- Feature management (enabled/disabled features)
- Comprehensive health checks (liveness, readiness, startup probes)
- Support for admin and database credentials via secrets
- Development and production mode configuration
- Hostname configuration with admin and backchannel options
- HTTP and HTTPS port configuration
- Proxy mode support (edge, reencrypt, passthrough, none)