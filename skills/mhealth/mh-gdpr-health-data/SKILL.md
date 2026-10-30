---
name: mh-gdpr-health-data
description: Assess how a feature or system processes health data against core GDPR principles — purpose, legal basis, minimisation, retention, data subject rights, data protection by design, and whether a DPIA is likely needed. Use when a feature collects, shares, exports, retains or deletes data about people.
argument-hint: "[feature or data flow]"
---

# GDPR for health data (level 3)

Engineers do not decide the legal basis, but they build what makes compliance possible or impossible.

## Principles

- Health data is a special category (art. 9); processing needs a legal basis (art. 6) **and**
  an art. 9 condition — decided by the controller, not the developer.
- Art. 5 principles as engineering questions: purpose limitation, data minimisation, accuracy,
  storage limitation, integrity and confidentiality, accountability.
- Art. 25: data protection by design and by default — the default setting must be the most
  privacy-protective one.
- Large-scale processing of health data or systematic monitoring is a typical trigger for a
  DPIA (art. 35). Flag it; the controller decides.

## Steps

1. Start from the data inventory (`mh-data-inventory`). Name the purpose of each flow.
2. For each flow ask: is every field necessary for the purpose? Who decides the legal basis?
3. Check that the system can technically honour the rights: access (export), rectification,
   erasure, restriction, portability — and how long each takes.
4. Check retention: is there a rule, and does any code enforce it?
5. List what must be decided by the controller (legal basis, DPIA, retention period) as
   questions, not as answers.

## Output

| Flow / feature | Purpose | Minimal? | Rights supported technically | Retention enforced? | Needs controller decision |
|----------------|---------|----------|------------------------------|---------------------|---------------------------|

## Done when

- Every gap is phrased as either an engineering fix or a question for the controller.
- No statement claims the system "is GDPR compliant"; compliance is not a property of code alone.

Not legal advice. Source: Regulation (EU) 2016/679 (GDPR), arts. 5, 6, 9, 25, 35.
