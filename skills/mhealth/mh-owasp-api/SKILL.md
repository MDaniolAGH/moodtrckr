---
name: mh-owasp-api
description: Review a REST API against the OWASP API Security Top 10 (2023), with each finding demonstrated by a concrete request. Use when reviewing backend endpoints, after adding or changing an endpoint, or before exposing an API outside a local network.
argument-hint: "[endpoint or router, e.g. /moods]"
---

# OWASP API Security Top 10 (level 2)

Check the API the way an attacker would: by sending requests, not by reading intentions.

## Categories (OWASP API Security Top 10, 2023)

| ID | Risk | Typical question |
|----|------|------------------|
| API1 | Broken Object Level Authorization | Can user A read or change user B's object by changing an ID? |
| API2 | Broken Authentication | Are tokens validated, expired, revocable? Brute force limited? |
| API3 | Broken Object Property Level Authorization | Can a client read or set fields it should not? |
| API4 | Unrestricted Resource Consumption | Limits on page size, payload size, request rate? |
| API5 | Broken Function Level Authorization | Can a normal user call admin or internal functions? |
| API6 | Unrestricted Access to Sensitive Business Flows | Can a flow be automated or abused at scale? |
| API7 | Server Side Request Forgery | Does the API fetch URLs supplied by the client? |
| API8 | Security Misconfiguration | CORS, debug, default secrets, verbose errors, missing TLS? |
| API9 | Improper Inventory Management | Undocumented, old or test endpoints exposed? |
| API10 | Unsafe Consumption of APIs | Is data from third-party APIs trusted without validation? |

## Steps

1. List endpoints (OpenAPI at `/docs` helps) with auth requirements.
2. For each relevant category, design a test request with two synthetic users.
3. Run it against a local instance and record the response.
4. Rate each finding by impact on health data, not by category number.

## Output

```
[API1 | HIGH] GET /resource/{id} — scenario: user B requests user A's id → expected 404, got <status>
  Evidence: <request> → <response>
  Fix: <smallest change>
```

Also list categories checked with no finding, and categories not applicable (with reason).

## Done when

- Every finding has a reproducible request and response, using synthetic data only.
- "Not vulnerable" is stated only for categories that were actually tested.

Source: OWASP API Security Top 10 2023 (owasp.org). Check for a newer edition before use.
