Write commit messages in this format:

```
<type>(<scope>): <imperative summary, max 72 characters>

<Why: 1–3 sentences describing the problem, not the code.>

Verified: <command> → <result>
Not verified: <what and why>   (omit if everything was verified)
Refs: <ISSUE-ID>
ADR: <ADR-ID>                  (omit if none)
AI-assisted: GitHub Copilot     (when the change was produced with an AI agent)
```

Rules:
- Types: feat, fix, test, docs, refactor, chore, ci, security. Scopes: api, app, db, docs, ci.
- Only list verification that is visible in this session or the diff; never invent results.
- If no issue ID is known, write `Refs: none` rather than guessing.
- Never include personal data, tokens or log excerpts.
