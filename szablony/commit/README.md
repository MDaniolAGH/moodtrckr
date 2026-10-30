# Szablon commitu

Dwa pliki, ten sam format:

| Plik | Dla kogo | Jak podłączyć |
|------|----------|---------------|
| `gitmessage.txt` | człowiek (`git commit` otwiera edytor z szablonem) | `git config commit.template .gitmessage.txt` |
| `commit-instructions.md` | Copilot (przycisk ✨ generowania opisu commitu w Source Control) | ustawienie w `.vscode/settings.json`, niżej |

## Podłączenie w repozytorium

```bash
cp moodtrckr/szablony/commit/gitmessage.txt <repo>/.gitmessage.txt
cp moodtrckr/szablony/commit/commit-instructions.md <repo>/.github/commit-instructions.md
cd <repo> && git config commit.template .gitmessage.txt
```

`.vscode/settings.json`:

```json
{
  "github.copilot.chat.commitMessageGeneration.instructions": [
    { "file": ".github/commit-instructions.md" }
  ]
}
```

Ustawienie jest oznaczone w VS Code jako eksperymentalne; nazwa może się zmienić.
Opis commitu generuje mniejszy model pomocniczy, nie ten wybrany w czacie.

## Przykład dobrego commitu

```
fix(api): return 404 for mood entries of other users on update

Updating an entry checked only that it exists, not who owns it.
Participants could overwrite other participants' entries by ID.

Verified: pytest -q tests/test_moods.py → 6 passed (incl. test_update_other_users_entry_returns_404)
Verified: flutter test → 28 passed
Refs: ISSUE-004
Risk: R-02
AI-assisted: GitHub Copilot
```

Przykład jest ilustracyjny (format), nie opisuje znanego błędu w Mood Trackerze.

## Czego uczy

- **Dlaczego**, a nie co — „co” widać w diffie.
- **Jak sprawdzono** — commit bez dowodu to hipoteza.
- **Traceability** — od wymagania (issue) przez decyzję (ADR) do kodu i testu.
- **Jawny udział AI** — kto przejrzał i przyjął zmianę.
