---
name: test-first-fix
description: Fix a bug by first writing a test that reproduces it, then making the smallest change that makes it pass. Use for any bug report, failing behaviour or regression, in the Flutter app or the backend.
---

# Test-first bug fix

## Steps

1. **Reproduce.** Write down the observed vs expected behaviour in one line each. Find the
   smallest input that shows the bug.
2. **Write a failing test** at the lowest level that can show the bug (domain function before
   API test, API test before widget test). Name it after the behaviour, e.g.
   `test_alert_fires_after_two_days_at_38_degrees`.
3. **Run it and show it fails** for the expected reason. A test that fails for a different reason
   (import error, wrong fixture) does not count; fix the test first.
4. **Fix** with the smallest change that makes the test pass. Do not refactor in the same step.
5. **Run the full suite** for the affected part (`pytest -q` and/or `flutter test`) plus
   linters. Show the output.
6. **Commit** test and fix together: `fix: <behaviour> (#<issue>)`.

## Stop and ask when

- The "bug" might be intended behaviour (especially clinical thresholds or data retention).
- The fix needs a schema change or an API contract change.
- You cannot reproduce it after two honest attempts — report what you tried.

## Report format

```
Bug: <observed> — expected <expected>
Root cause: <path>:<line> — <why>
Test: <test name> — failed before (output), passes after (output)
Change: <files touched, one line each>
Suite: <command> → <pass/fail summary>
```
