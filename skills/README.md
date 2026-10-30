# Skille (GitHub Copilot)

| Folder | Skille |
|--------|--------|
| `business-analyst/` | `ba-decision-statement`, `ba-assumptions`, `ba-questions`, `ba-app-observation`, `ba-define-terms`, `ba-stakeholders`, `ba-requirements`, `ba-options`, `ba-recommendation` |
| główny | `verify-claim`, `test-first-fix`, `pr-review` |

## Instalacja w repozytorium

Copilot szuka skilli w `.github/skills/<nazwa>/SKILL.md` — każdy skill jako **bezpośredni**
podfolder (bez `business-analyst/` pośrodku). Nazwa folderu musi być równa polu `name`.

```bash
SK="$HOME/SynologyDrive/AGH/Dydaktyka/Aplikacje Mobilne w Chirurgii/2026/skills"
REPO=~/dev/<repozytorium>
mkdir -p "$REPO/.github/skills"
cp -R "$SK"/business-analyst/ba-* "$REPO/.github/skills/"        # zestaw BA
cp -R "$SK"/verify-claim "$SK"/test-first-fix "$SK"/pr-review "$REPO/.github/skills/"
```

Skille osobiste (dla wszystkich projektów): `~/.copilot/skills/` zamiast `.github/skills/`.

## Użycie

- Copilot Chat w trybie **Agent** ładuje skill sam, gdy `description` pasuje do zadania —
  bez gwarancji, że zrobi to za każdym razem.
- Wywołanie wprost: `/ba-questions C02`, `/verify-claim`, `/pr-review`.
- Rozwiń **References** pod odpowiedzią, żeby sprawdzić, czy skill został załadowany.
- Jeśli skille nie są wykrywane, włącz ustawienie `chat.useAgentSkills`.

Format `SKILL.md` jest wspólny dla wielu narzędzi; te same pliki działają też w Claude Code
(`.claude/skills/`).

Źródło: https://code.visualstudio.com/docs/agent-customization/agent-skills (sprawdzone 30.10.2026)
