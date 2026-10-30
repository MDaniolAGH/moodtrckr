---
name: ba-assumptions
description: Separate facts from assumptions and unknowns, rate the risk of each assumption, and say how to check it. Use when preparing for a client conversation, reviewing a proposal, or when a statement "everyone knows" has not been confirmed.
argument-hint: "[kod klienta, np. C02, lub ścieżka do briefu]"
---

# Assumption log

Every recommendation rests on assumptions. Make them visible so they can be checked before
they become expensive.

## Principles

- **Fact**: stated in the brief, by the client, or shown in the code/app with evidence.
  **Assumption**: something you treat as true without confirmation. **Unknown**: something you
  know you do not know.
- An assumption is useful only if it is specific enough to be wrong.
- Rank by **impact if wrong**, not by how likely it feels.

## Steps

1. List everything your thinking relies on: users, devices, connectivity, data, process,
   responsibilities, budget, regulation, the existing app.
2. Label each item Fact / Assumption / Unknown. Facts need a source.
3. For each assumption: what changes in the recommendation if it is wrong (High / Medium / Low),
   and the cheapest way to check it (ask the client, read the code, run the app, test with
   synthetic data).
4. Keep the top 3–5 high-impact assumptions; the rest go to a backlog.

## Output

| # | Statement | Type | Source / how to check | Impact if wrong |
|---|-----------|------|-----------------------|-----------------|

Write the output in the language of the client brief.

## Done when

- No assumption is labelled a fact without a source.
- Each high-impact assumption has a concrete way to check it.
