# AGENTS.md — PostOp Companion

Instructions for coding agents working in this repository. Humans: see `docs/` for product docs.

## Product in one paragraph

PostOp Companion is a recovery diary for patients after elective surgery. Patients log daily pain
(0–10 NRS), body temperature and wound photos; the backend flags entries that match clinical alert
rules (e.g. temperature ≥ 38.0 °C on two consecutive days) and notifies the care team. The app is
used by patients at home, often on older Android phones and unreliable networks.

## Repository layout

```
app/                Flutter client
  lib/features/     one folder per feature: data/ domain/ presentation/
  lib/core/         networking, storage, routing, theme
  test/             unit + widget tests, mirrors lib/
backend/            FastAPI service
  src/postop/       api/ (routers), domain/ (pure logic), db/ (SQLAlchemy models, repositories)
  migrations/       Alembic migrations
  tests/            pytest; tests/integration needs Docker
docs/adr/           architecture decision records
```

## Commands

Run these exactly; do not invent alternatives.

| Task | Command (from repo root) |
|------|--------------------------|
| Backend setup | `cd backend && uv sync` |
| Backend tests | `cd backend && uv run pytest -q` |
| Backend integration tests | `cd backend && docker compose up -d db && uv run pytest -q tests/integration` |
| Backend lint + types | `cd backend && uv run ruff check . && uv run mypy src` |
| New DB migration | `cd backend && uv run alembic revision --autogenerate -m "<message>"` |
| App deps | `cd app && flutter pub get` |
| App analyze | `cd app && flutter analyze` |
| App tests | `cd app && flutter test` |
| Regenerate code (drift, freezed) | `cd app && dart run build_runner build --delete-conflicting-outputs` |

## Definition of done

A change is done only when all of these hold. Report the output, not a summary of it.

1. `flutter analyze` and `flutter test` pass (if `app/` changed).
2. `ruff`, `mypy` and `pytest` pass (if `backend/` changed).
3. New behaviour has a test that failed before the change.
4. Schema changes come with an Alembic migration, and the migration was applied to a fresh DB.
5. API changes are reflected in `backend/openapi.snapshot.json` (`uv run python -m postop.export_openapi`)
   and in the Dart client in `app/lib/core/api/`.

## Architecture rules

- Flutter: Riverpod for state, `go_router` for navigation, `drift` for local storage.
  Widgets never call HTTP or the database directly; they go through a repository in `data/`.
- Offline first: every patient entry is written locally first and synced by `SyncService`.
  Never drop an unsynced entry; on sync conflict the server version wins and the local one is
  kept in `conflicts` for review.
- Backend: routers stay thin. Business rules (alert thresholds, scoring) live in `domain/` as pure
  functions with unit tests. No SQL outside `db/repositories/`.
- All timestamps are stored in UTC (timezone-aware) and converted to local time only in the UI.
- Alert rules are clinical logic: thresholds come from `domain/alert_rules.py` and are covered by
  tests named after the rule. Do not change a threshold without an explicit instruction that
  quotes the new value.

## Conventions

- Dart: `flutter_lints` + `very_good_analysis`; files `snake_case.dart`, one public widget per file.
- Python: 3.12, type hints everywhere, `ruff format`. Errors from the API use
  `{"error": {"code": "...", "message": "..."}}`.
- Commits: Conventional Commits (`feat:`, `fix:`, `test:`, `refactor:`), one logical change each.
- Branches: `feature/<issue-id>-short-name`, `fix/<issue-id>-short-name`.

## Never

- Never put real patient data anywhere: code, tests, fixtures, logs, prompts or screenshots.
  Use `backend/tests/factories.py` for synthetic data.
- Never log request bodies, photos, tokens or anything that identifies a patient.
- Never commit secrets. Configuration comes from environment variables; see `backend/.env.example`.
- Never disable a failing test, lower coverage thresholds or add `# type: ignore` / `// ignore:`
  to make a check pass. Fix the cause or stop and report.
- Never edit generated files (`*.g.dart`, `*.freezed.dart`, `openapi.snapshot.json`) by hand.
- Never run destructive commands (`alembic downgrade`, `docker compose down -v`, `git push --force`,
  `rm -rf`) without being asked.

## Working style

- Before changing code, state the plan in a few bullet points and list the files you will touch.
- Make claims about this codebase only with a file path and line number you have read.
  If you have not verified something, say so.
- Prefer the smallest change that satisfies the issue. Do not refactor unrelated code.
- If a requirement is ambiguous or touches clinical logic, ask instead of guessing.
- When a command fails, show the error and your diagnosis before retrying.

## Skills

Skills live in `.github/skills/<name>/SKILL.md`. Copilot loads a skill when its `description`
matches the task; this table makes the expected use explicit. If a task matches a row, use that
skill and follow its output format.

| Skill | Use when |
|-------|----------|
| `ba-analyst` | A client brief or feature request arrives, before any design or code |
| `verify-claim` | Stating how the code works, or checking a claim from a person or another agent |
| `test-first-fix` | Fixing any bug or regression |
| `pr-review` | Reviewing a diff, a branch or a patch from an external vendor |

To add a skill: create `.github/skills/<name>/SKILL.md` with `name` (equal to the folder name)
and `description` (what it does and when to use it), then add a row to this table.

## Useful context

- ADRs in `docs/adr/` explain past decisions (e.g. ADR-004: why drift instead of sqflite). Read the
  relevant ADR before proposing to change an architectural choice.
- Demo accounts for local runs: created by `uv run python -m postop.seed`; password in the script output.
