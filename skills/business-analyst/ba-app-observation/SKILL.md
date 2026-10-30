---
name: ba-app-observation
description: Record an observation about the existing app that matters for this client, separating what was observed from how it is interpreted, with evidence. Use when analysing an inherited system for a client, or when someone claims the app "does" or "cannot do" something.
argument-hint: "[kod klienta, np. C02, lub ścieżka do briefu]"
---

# Observation from the existing app

Inherited systems are full of surprises. Report what you saw, prove it, and explain why it
matters to *this* client — without assuming a defect.

## Principles

- **Observation** is what the app or code does, shown with evidence. **Interpretation** is what
  it might mean. **Implication** is why the client should care. Keep them separate.
- Do not start from "find the bug". Start from the client's concern and ask what the app
  actually does in that area.
- Evidence is a file and line, a reproducible run with synthetic data, or a screenshot.
  Comments and documentation are not evidence of behaviour.

## Steps

1. Pick the client's main concern from the brief.
2. Find the part of the app that touches it (data model, storage, sync, reporting, UI flow).
3. Read the code and, where possible, run the app with synthetic data to see the behaviour.
4. Write the observation; check it with `verify-claim` if available.
5. State the implication for this client and what is still unknown.

## Output

```
Client concern: <from the brief>
Observation: <what the app does> — evidence: <path:line | steps + result>
Interpretation: <what it may mean; label uncertain parts>
Implication for the client: <why it matters to their decision>
Still unknown: <what would need checking>
```

Write the output in the language of the client brief.

## Done when

- The observation is reproducible by someone else from the evidence alone.
- The word "bug" appears only if expected behaviour was agreed and the app contradicts it.
