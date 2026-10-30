---
name: mh-iec62304-traceability
description: Build and check traceability between requirements, design decisions, code, tests and risk controls, list third-party software (SOUP), and propose a software safety class with justification, in the spirit of IEC 62304. Use when a change must be auditable, before a release, or when asked "how do we know this requirement is tested?".
argument-hint: "[requirement ID or feature]"
---

# IEC 62304-style traceability (level 4)

In medical device software, "it works" is not enough: you must show why it was built, how,
and how you know it works.

## Principles

- **Traceability**: each requirement links to design, implementation and verification; each
  test links back to a requirement or risk control. Gaps in either direction are findings.
- **Software safety class** (A / B / C) depends on the worst harm a software failure could
  contribute to, after external risk controls: A — no injury possible, B — non-serious injury,
  C — death or serious injury. It drives how much process rigour is required.
- **SOUP** (software of unknown provenance): every third-party library is listed with version,
  purpose and known anomalies, and is monitored.

## Steps

1. Collect requirements (issues, requirement files) with IDs.
2. For each requirement find: design decision (ADR), code (commits, files), tests (names).
3. Find orphans: code or tests with no requirement; requirements with no test.
4. List SOUP from dependency files (`requirements.txt`, `pubspec.yaml`, lock files) with versions.
5. Propose a safety class with a one-paragraph justification based on the intended purpose
   (`mh-intended-purpose`) and risk analysis (`mh-iso14971-risk`). Mark it as a proposal.

## Output

| Requirement | Design (ADR) | Code (commit / file) | Verification (test) | Risk control |
|-------------|--------------|----------------------|---------------------|--------------|

Then: orphans, SOUP table (name, version, purpose, known issues), proposed class with justification.

## Done when

- Every requirement has a test or is marked "not verified".
- The SOUP list matches the lock files exactly.

Not a conformity assessment. Source: IEC 62304:2006 + A1:2015. Check the current edition before use.
