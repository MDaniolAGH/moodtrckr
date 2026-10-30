---
name: pr-review
description: Review a pull request or local diff for correctness, tests, security and health-data handling, and report findings ranked by severity. Use when asked to review a PR, a branch, a patch from an external vendor, or your own changes before opening a PR.
---

# Pull request review

## Steps

1. Get the diff (`git diff main...HEAD` or `gh pr diff <n>`) and the linked issue. Read the
   issue first: review against what was asked, not only against what was written.
2. Run the checks yourself: analyzer, linters, tests. A PR with failing checks gets one finding
   ("checks fail") with the output, and the review stops there.
3. Read every changed file in full context, not only the changed lines.
4. Go through the checklist below. For each finding, try to show it: a failing input,
   a test, or a concrete scenario.

## Checklist

**Correctness**
- Does the change do what the issue asks — all acceptance criteria, nothing extra?
- Edge cases: empty lists, null fields, time zones and day boundaries, offline/slow network,
  duplicate submissions, app killed mid-sync.
- Error handling: are failures surfaced or silently swallowed?

**Tests**
- Is there a test that would fail without this change?
- Do tests assert behaviour, not implementation details?

**Security and health data**
- Authorization: can a user read or change another user's data?
- No patient data, tokens or photos in logs, errors, analytics or test fixtures.
- No secrets in code or config committed to the repo.
- Input validation on every new API field.

**Maintainability**
- Follows the architecture rules in AGENTS.md (layers, offline-first, UTC).
- Migrations for schema changes; generated files regenerated, not hand-edited.

## Report format

Findings ranked most severe first:

```
[BLOCKER | MAJOR | MINOR] <path>:<line> — <one-sentence problem>
  Scenario: <input or steps> → <wrong result>
  Suggestion: <smallest fix>
```

End with a verdict: **Approve**, **Approve with minor changes**, or **Request changes**.
Say explicitly if you found no issues and what you checked to reach that conclusion.
