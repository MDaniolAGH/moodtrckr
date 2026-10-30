---
name: ba-define-terms
description: Turn vague business terms into operational definitions that people and code can apply the same way, and list the edge cases each definition must decide. Use when a term is used by several people, appears in a report or metric, or two results that "should match" do not.
argument-hint: "[kod klienta, np. C02, lub ścieżka do briefu]"
---

# Operational definitions

Many disagreements are not about data but about words. "Entry", "day", "participant",
"missing", "summary" can each mean several things.

## Principles

- A term is defined when two people, given the same data, would classify every case the same way.
- Definitions are decided by the client (they own the meaning); the analyst finds the cases
  that need deciding.
- A definition that exists only in someone's head does not survive handover.

## Steps

1. Collect the key terms from the brief, the client's words and any reports or metrics.
2. For each term, write how each stakeholder seems to use it. Note differences.
3. List edge cases that a definition must decide (boundaries, duplicates, late or edited data,
   exclusions, time zones, partial records).
4. Draft a definition with an explicit rule for each edge case, and mark who must approve it.
5. Check how the existing app or data actually represents the term.

## Output

| Term | Proposed definition | Edge cases and rule | How the app represents it | Owner / status |
|------|---------------------|---------------------|---------------------------|----------------|

Write the output in the language of the client brief.

## Done when

- Each edge case has a rule or is marked "to decide by <owner>".
- Someone new could compute the same number from the definitions alone.
