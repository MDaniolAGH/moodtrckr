# Workflowy i rozmieszczenie plików w Copilot (VS Code)

Uzupełnienie do `README.md`. Stan dokumentacji VS Code sprawdzony 30.10.2026.

## Dwa tryby uruchamiania („harness”)

VS Code uruchamia agenta w jednym z dwóch trybów. Nie każdy mechanizm działa w obu.

| Mechanizm | Local (agent VS Code) | Copilot harness |
|-----------|-----------------------|-----------------|
| `AGENTS.md`, `.github/copilot-instructions.md` | tak | tak |
| Skille `.github/skills/<nazwa>/SKILL.md` | tak | tak (zalecany sposób na powtarzalne workflowy) |
| Agenci `.github/agents/*.agent.md` | tak | tak |
| Przyciski przekazania (`handoffs`) | tak | brak potwierdzenia w dokumentacji — sprawdź |
| Prompt files `.github/prompts/*.prompt.md` | tak | **nie** (dokumentacja: Copilot harness ich nie wczytuje) |
| Koordynator z subagentami (`tools: ['agent']` + `agents`) | tak (`runSubagent`) | inny mechanizm delegowania; nazwy narzędzi nie są przenośne |

Wniosek: **workflow, który ma działać wszędzie, zapisz jako skill.** Prompt files i handoffs
są wygodne w trybie Local.

## Gdzie Copilot szuka skilli

| Zakres | Lokalizacja |
|--------|-------------|
| Projekt | `.github/skills/<nazwa>/SKILL.md`, `.claude/skills/<nazwa>/SKILL.md`, `.agents/skills/<nazwa>/SKILL.md` |
| Osobiste (wszystkie projekty) | `~/.copilot/skills/`, `~/.claude/skills/`, `~/.agents/skills/` |

Warunki:
1. Każdy skill w **osobnym podfolderze** jednej z tych lokalizacji.
2. Plik nazywa się dokładnie **`SKILL.md`** (nie `SKILLS.md`, `skill.md`, `README.md`).
3. Pole `name` w nagłówku jest **równe nazwie folderu** (małe litery, cyfry, myślniki).

`SKILL.md` w katalogu głównym albo np. w `docs/skills/`:
- **nie jest skillem** — nie ładuje się automatycznie i nie ma polecenia `/nazwa`;
- może być zwykłym dokumentem: jeśli `AGENTS.md` każe go przeczytać, agent zrobi to narzędziem
  `read` — ale tylko wtedy, gdy posłucha instrukcji.

Ustawienie `chat.agentSkillsLocations` dodaje własne foldery skilli (te same warunki), ale
dokumentacja jest niespójna co do jego wycofania, a Copilot CLI i aplikacja Copilot go nie czytają.
Na kursie: tylko `.github/skills/`.

## Cztery sposoby na workflow „rozwój funkcji”

| Sposób | Plik w tym folderze | Kto steruje kolejnością | Do czego |
|--------|---------------------|-------------------------|----------|
| **Agenci z przekazaniem** | `github/agents/*.agent.md` (7 kroków) | człowiek naciska przycisk przy każdym kroku | główny tryb na kursie: człowiek zatwierdza każde przejście |
| **Prompt file** | `github/prompts/feature.prompt.md` → `/feature` | jeden agent w jednej rozmowie, startuje od kroku 1 | szybkie wejście w łańcuch (tylko Local) |
| **Skill-workflow** | `github/skills/feature-development/SKILL.md` | agent według procedury, z punktami zatrzymania | działa w obu trybach; „dodaj funkcję…” zawsze uruchamia ten sam proces |
| **Koordynator z subagentami** | `github/agents/koordynator.agent.md` | agent-koordynator, bez człowieka między krokami | eksperyment porównawczy: co agent zdecydował sam |

Instalacja w repozytorium projektu (oprócz kroków z `README.md`):

```bash
L=moodtrckr/lancuch-agentow
mkdir -p <repo>/.github/prompts <repo>/.github/skills
cp $L/github/prompts/*.prompt.md <repo>/.github/prompts/
cp -R $L/github/skills/feature-development <repo>/.github/skills/
cp $L/github/agents/koordynator.agent.md <repo>/.github/agents/
```

Wywołanie: `/feature Uczestnik chce usunąć swoje konto i dane` albo wybór agenta
`koordynator` z listy agentów. Koordynator korzysta z agentów jako subagentów — w starszych
wersjach VS Code wymagało to ustawienia `chat.customAgentInSubagent.enabled`.

## Eksperyment: człowiek w pętli a pełna automatyzacja (2 × 30 min)

Ta sama funkcja, dwie pary, osobne kopie repozytorium:

| | Para A | Para B |
|--|--------|--------|
| Sposób | agenci z przekazaniem, zatwierdzanie każdego kroku | agent `koordynator`, bez ingerencji |
| Zapisujecie | każdą decyzję, którą podjęliście przy przycisku | tabelę „decyzji bez człowieka” z raportu koordynatora |

Porównanie na koniec (`git diff` między kopiami + pliki `docs/`):
1. Które decyzje koordynator podjął sam, a para A podjęła świadomie?
2. Gdzie wyniki się różnią: zakres, wariant w ADR, liczba zmienionych plików, testy?
3. Który wynik łatwiej przejrzeć i obronić przed klientem?

Wniosek do nazwania: automatyzacja przyspiesza, ale przesuwa decyzje z człowieka na agenta —
trzeba je potem odnaleźć i zweryfikować.

## Źródła

- https://code.visualstudio.com/docs/agent-customization/agent-skills
- https://code.visualstudio.com/docs/agent-customization/prompt-files
- https://code.visualstudio.com/docs/agent-customization/custom-agents
- https://code.visualstudio.com/docs/agents/run/subagents
- https://code.visualstudio.com/docs/agent-customization/migrate-customizations
