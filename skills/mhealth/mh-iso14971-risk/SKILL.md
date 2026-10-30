---
name: mh-iso14971-risk
description: Run a small risk analysis for a feature in the spirit of ISO 14971 — hazards, sequences of events, hazardous situations, harms, risk estimation, risk controls and their verification. Use before implementing a feature that touches health data or health-related decisions, or when a bug could affect a person.
argument-hint: "[feature or failure, e.g. lost offline entry]"
---

# ISO 14971-style risk analysis (level 4)

Ask "what could go wrong for a person?" before "what could go wrong in the code?".

## Concepts

- **Hazard**: potential source of harm (e.g. wrong data shown).
- **Sequence of events → hazardous situation**: how a person becomes exposed (e.g. an entry is
  lost offline, the summary looks complete, the clinician relies on it).
- **Harm**: injury or damage to health (or, in a broader view, privacy harm).
- **Risk** = combination of the probability of harm and its severity.
- **Risk control**: by priority — inherently safe design, then protective measures, then
  information for safety. Each control must be **verified**.

## Steps

1. Describe the feature and its intended purpose (`mh-intended-purpose`).
2. Brainstorm failures: software bugs, data loss, wrong time zone, misuse, misunderstanding.
3. For each, write the sequence of events to a hazardous situation and the possible harm.
4. Estimate severity and probability on a simple agreed scale; state the scale.
5. Propose risk controls, preferring design changes over warnings.
6. For each control, name how it will be verified (test, inspection, usability check).
7. State the residual risk and who must accept it.

## Output

| # | Hazard | Sequence of events → hazardous situation | Harm | Severity | Probability | Risk control | Verification | Residual risk |
|---|--------|------------------------------------------|------|----------|-------------|--------------|--------------|---------------|

## Done when

- Every control has a verification method that can actually be run.
- Software failure probability is not claimed to be zero; assume software can fail.

Not a regulatory risk file. Source: ISO 14971:2019, ISO/TR 24971:2020. Check current editions before use.
