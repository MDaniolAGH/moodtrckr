---
name: verify-claim
description: Verify a statement about this codebase before relying on it — find the code that proves or refutes it and report the evidence. Use when asked "is it true that…", when auditing a document or another agent's output, or before stating how something works.
---

# Verify a claim about the codebase

Goal: turn a statement into a verdict backed by evidence a reviewer can check in under a minute.

## Steps

1. Restate the claim as one testable sentence. If it bundles several facts, split it and verify
   each separately.
2. Locate the code: search for the symbols, routes, table names or strings involved. Read the
   relevant functions in full, including callers, not only the line that matched.
3. If the claim is about behaviour, not structure, check it by running something:
   an existing test, a new minimal test, or a request against the local API.
   Prefer running over reasoning.
4. Decide one verdict:
   - **CONFIRMED** — code and (where applicable) a run agree with the claim.
   - **REFUTED** — code or a run contradicts it.
   - **PARTLY TRUE** — true only under conditions; name them.
   - **UNVERIFIED** — you could not find or run the evidence; say what is missing.

## Report format

```
Claim: <one sentence>
Verdict: CONFIRMED | REFUTED | PARTLY TRUE | UNVERIFIED
Evidence:
  - <path>:<line> — <what this line shows>
  - <command> → <relevant output>
Notes: <conditions, edge cases, or what would change the verdict>
```

## Rules

- Every piece of evidence has a file path with line number or a command with its output.
- Do not upgrade UNVERIFIED to CONFIRMED because something "usually works this way".
- Comments and docs are not evidence of behaviour; code and runs are.
