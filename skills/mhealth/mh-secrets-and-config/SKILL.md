---
name: mh-secrets-and-config
description: Check how secrets and environment-specific settings are handled — keys, tokens, passwords, URLs, debug flags — and whether insecure defaults can reach production. Use when reviewing configuration, before a release, or when a change touches authentication or deployment.
argument-hint: "[component, e.g. API or mobile app]"
---

# Secrets and configuration (level 1)

Most real incidents start with a secret in the wrong place or a development default left on.

## Principles

- Secrets never live in source code, committed config, mobile app bundles or logs.
- A **default that works in development** (dev secret key, permissive CORS, debug mode) is a
  finding if nothing prevents it from being used in production.
- Anything shipped inside a mobile app can be extracted by the user. A mobile app cannot keep
  a server-side secret.

## Steps

1. Search for hard-coded keys, passwords, tokens and default values of security settings.
2. List every configuration value, its source (env var, file, constant) and its default.
3. For each insecure default, check whether startup fails, warns, or silently accepts it.
4. Check what the mobile app bundles at build time (`--dart-define`, constants, assets).
5. Check `.gitignore` and the history for committed secrets or databases.

## Output

| Setting | Source | Default | Risk if default used in production | Guarded? (fails / warns / no) | Evidence |
|---------|--------|---------|------------------------------------|-------------------------------|----------|

## Done when

- Every insecure default has a stated risk and a proposed guard (e.g. refuse to start).
- Nothing secret is reported as "fine because it is only for development" without a guard.
