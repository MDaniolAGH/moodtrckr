---
name: mh-data-inventory
description: Build an inventory of personal and health data in the system — what is collected, where it is stored, where it flows and who can access it. Use before any security, privacy or compliance review, and whenever a feature adds, moves or shares data about people.
argument-hint: "[component or feature, e.g. mood entries]"
---

# Health data inventory (level 1)

You cannot protect, minimise or justify data you have not listed.

## Principles

- Health data (including self-reported mood or wellbeing) is a **special category** of personal
  data under GDPR art. 9. Treat it as such by default.
- Data lives in more places than the database: device storage, caches, logs, backups, exports,
  crash reports, analytics, test fixtures.
- Every item needs a **reason to exist**. "Might be useful" is not a reason.

## Steps

1. Walk the code from input (UI, API request) to every place data is written or sent.
2. For each data item record: what it is, where it is stored (file:line), whether it is
   encrypted, who can read it, how long it is kept, and why it is needed.
3. Mark items found outside the intended store (logs, plain-text device storage, fixtures).
4. Mark unknowns explicitly (e.g. retention not defined anywhere).

## Output

| Data item | Category (personal / health / technical) | Stored where (file:line) | Encrypted? | Who can access | Retention | Purpose |
|-----------|------------------------------------------|--------------------------|------------|----------------|-----------|---------|

Then: items with no purpose, items in unexpected places, unknowns.

## Done when

- Every row has evidence (file:line) or is marked as an unknown.
- Device-side storage and logs were checked, not only the server database.
