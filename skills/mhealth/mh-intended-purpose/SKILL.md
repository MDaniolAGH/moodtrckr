---
name: mh-intended-purpose
description: State the intended purpose of a feature or app and check whether a change in function could move it toward qualification as medical device software. Use before adding features that interpret, score, alert on or recommend actions based on health data.
argument-hint: "[feature, e.g. weekly mood summary]"
---

# Intended purpose and medical device qualification (level 3)

The same output can be a diary or a medical device, depending on what it is for.

## Principles

- Intended purpose answers: **for whom, in what situation, for which action, with what
  consequences**.
- Qualification depends on the intended purpose and the function of the software — e.g. whether
  it processes data to support diagnosis, monitoring, treatment or prediction — not on a label
  such as "research" or "informational", and not only on who makes the final decision.
- Storing, displaying or simple searching of data usually does not qualify on its own;
  interpreting, scoring, alerting or recommending may.

## Steps

1. Write the intended purpose of the current system in four lines (who / situation / action /
   consequence).
2. For the proposed feature, write the same four lines.
3. Compare: does the feature add interpretation, alerts, scores or recommendations that
   influence a health-related decision?
4. If yes, flag it: the feature changes the evidence needed (technical, usability, clinical)
   and needs a regulatory qualification decision by the manufacturer.
5. Propose a variant of the feature that keeps the original purpose, if one exists.

## Output

```
Current purpose:  who / situation / action / consequence
Feature purpose:  who / situation / action / consequence
Change in function: <none | adds interpretation | adds alerting | adds recommendation>
Flag: <no change | needs qualification decision> — reason
Lower-risk variant: <description or "none">
```

## Done when

- The comparison names the specific function that changes, with the screen or code involved.
- The output does not claim a classification; it flags the need for a decision.

Not regulatory advice. Sources: Regulation (EU) 2017/745 (MDR), Annex VIII Rule 11;
MDCG 2019-11 rev. 1. Check current versions before use.
