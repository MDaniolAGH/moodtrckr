---
name: ba-analyst
description: Prepare for a first client conversation from a client brief — the decision in one sentence, key assumptions, 3–5 ranked questions, and one observation from the existing app. Use when a client brief arrives or before the first meeting with a client.
argument-hint: "[client code, e.g. C02, or path to the brief]"
---

# Business analyst: first conversation

Understand the client's decision before proposing any solution.

## Steps

1. Read the brief. Note who decides, the constraints (budget, time, support capacity) and what
   worries the client.
2. **Decision**: write the client's decision in one sentence. No technology or vendor names.
3. **Assumptions**: list 3–5 things you take as true without confirmation. Mark each as
   fact (with source) or assumption.
4. **Questions**: write 3–5 open questions, ranked by how much the answer would change your
   recommendation. For each: "if the answer is A → we propose X; if B → Y".
5. **Observation**: one thing the existing app actually does that matters for this client,
   with file:line or a reproducible run.

## Rules

- Do not propose a solution, a vendor or a feature yet.
- Do not assume the app has a bug; describe what it does.
- Use only the brief, the client's answers and the code. Do not invent client answers.
- Synthetic data only. Write the output in the language of the brief.

## Output

```
Decision: <one sentence>
Assumptions: <list, each marked fact/assumption with source>
Questions: <ranked list, each with "if A → X; if B → Y">
Observation: <what the app does> — <file:line or steps>
```

For deeper work on one item, use `ba-decision-statement`, `ba-assumptions`, `ba-questions`
or `ba-app-observation`.
