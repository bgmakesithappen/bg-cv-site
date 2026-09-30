---
title: "Self-Hosted Homelab"
date: 2025-01-01
draft: false
tags: ["Docker Compose", "authentik", "Wiki.js", "PostgreSQL", "PiHole", "Synology", "Bash"]
categories: ["Infrastructure"]
description: "Production-grade homelab on a Synology NAS — self-hosted identity, DNS, documentation, and automated backups"
---

A production-grade homelab running on a **Synology DS923+ NAS**, built to practice the same infrastructure skills used in enterprise environments: identity management, container orchestration, network security, and automated recovery — at home scale.

## What's Running

| Service | Role |
|---|---|
| **Wiki.js** | Internal knowledge base and runbook documentation |
| **authentik** | Self-hosted OIDC/OAuth2 identity provider — SSO across all services |
| **PostgreSQL** | Backend for Wiki.js — users, pages, auth config |
| **PiHole** | Network-level DNS with local A records for all internal services |
| **Portainer** | Git-based Docker stack management, deploying from the repo's `main` branch |

## Architecture

**Identity & Access**

All services authenticate through authentik via OpenID Connect. A custom internal CA issues a wildcard `*.bghub.cc` certificate; the CA cert is injected into containers via `NODE_EXTRA_CA_CERTS` so internal HTTPS calls validate correctly without bypassing TLS.

Secrets (database password, OIDC client secret) are stored in Bitwarden — nothing sensitive is in the repo.

**Networking**

DSM's built-in reverse proxy terminates HTTPS and forwards each subdomain to the appropriate container on localhost. PiHole resolves `*.bghub.cc` to the NAS IP so all services are reachable by hostname on the local network. A scoped ed25519 SSH deploy key lets Wiki.js push page content back to a `content` branch on GitHub — write access limited to that one repo.

**Reliability**

A nightly `pg_dump` via DSM Task Scheduler creates rolling 14-day backups. Dumps land under `/volume1` so Synology Hyper Backup includes them in its offsite rotation automatically. GitHub Dependabot opens weekly PRs for Docker image updates; Postgres major-version bumps are excluded and handled with a documented upgrade procedure.

## Skills Demonstrated

- End-to-end OIDC/OAuth2 setup — running the IdP, not just consuming it
- Custom certificate authority and per-service cert injection
- Infrastructure-as-code via Docker Compose with Git-based deploy workflow
- Automated backup design with offsite-ready file placement
- DNS management, reverse proxy configuration, and scoped credential hygiene
