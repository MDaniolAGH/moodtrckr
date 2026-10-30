---
name: feature-development
description: Develop a new feature through the full workflow — discovery, issue, architecture decision, implementation, unit tests, integration tests, documentation — with a human approval point after each step. Use whenever someone asks to add, build or implement a feature.
argument-hint: "[feature request in one sentence]"
---

# Feature development workflow

Each step produces a file. The next step reads files, not the chat history.
**Stop after each step** and ask the user to approve before continuing.

| Step | Do | Output | Stop and ask |
|------|----|--------|--------------|
| 1. Discovery | Ask about the need (who, situation, current workaround, pain) before any solution. Check what the code does today (file:line). | `docs/features/<name>.md` (template `docs/szablony/discovery.md`) | "Is this need described correctly?" |
| 2. Issue | Turn the agreed discovery into scope, Given/When/Then acceptance criteria, risks for people, Definition of Done. | `issues/ISSUE-<NNN>-<name>.md` (template `docs/szablony/issue.md`) | "Do you accept these acceptance criteria?" |
| 3. Architecture | Present 2–3 options incl. "change nothing"; effects on data, security, tests, cost. | `docs/adr/ADR-<NNN>-<name>.md` (template `docs/szablony/adr.md`) | "Which option do you choose and why?" |
| 4. Implementation | Plan first, then the smallest change within the ADR. No new dependencies without asking. | code + report (files, checks, not verified) | "Do you accept the plan?" and "Do you accept the change?" |
| 5. Unit tests | At least one test per acceptance criterion; show each fails when the behaviour is wrong. | tests in `mood-tracker-api/tests/`, `mood_tracker/test/` | "Do these tests check the right behaviour?" |
| 6. Integration tests | End-to-end path through the real API and a temporary database, two synthetic users where data is personal. | `mood-tracker-api/tests/integration/` | "Are the untested areas acceptable?" |
| 7. Documentation | README for the changed part, CHANGELOG, PR description with the trace discovery → issue → ADR → commit → test. | `docs/pr/ISSUE-<NNN>.md` | "Is this ready for review?" |

## Rules

- Never skip step 1 because the request already names a solution.
- Never mark a step done without its output file.
- Synthetic data only; no personal data in code, tests, logs or commit messages.
- Commit messages follow `.github/commit-instructions.md` if present.
