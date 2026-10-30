# Łańcuch agentów: od pomysłu do dokumentacji

Siedmiu agentów Copilota, każdy z jednym zadaniem, wąskimi uprawnieniami i przyciskiem
przekazania (*handoff*) do następnego. Człowiek zatwierdza każde przejście — przycisk wypełnia
prompt, ale go nie wysyła (`send: false`).

```
1 odkrywca ──► 2 autor-issue ──► 3 architekt ──► 4 developer ──► 5 tester-jednostkowy ──► 6 tester-integracyjny ──► 7 dokumentalista
docs/features/  issues/          docs/adr/        kod              tests/ (unit)              tests/integration/         README, CHANGELOG, docs/pr/
```

| Krok | Agent | Narzędzia | Wolno edytować | Wynik | Człowiek decyduje o… |
|------|-------|-----------|----------------|-------|----------------------|
| 1 | `odkrywca` | read, search, edit | `docs/features/` | plik odkrycia | czy potrzeba jest dobrze opisana |
| 2 | `autor-issue` | read, search, edit | `issues/` | `ISSUE-NNN` z kryteriami Given/When/Then | przyjęciu kryteriów akceptacji |
| 3 | `architekt` | read, search, edit | `docs/adr/` | `ADR-NNN` | wyborze wariantu |
| 4 | `developer` | + execute | kod | zmiana + raport | planie i przyjęciu zmiany |
| 5 | `tester-jednostkowy` | + execute | `tests/`, `test/` | testy na każde kryterium | czy testy sprawdzają właściwe zachowanie |
| 6 | `tester-integracyjny` | + execute | `tests/integration/`, `integration_test/` | scenariusz end-to-end | czy luki w testach są akceptowalne |
| 7 | `dokumentalista` | + execute | README, CHANGELOG, `docs/pr/` | opis PR ze śladem | czy PR jest gotowy do przeglądu |

„Wolno edytować” jest zapisane w instrukcji agenta, a nie wymuszone przez narzędzie — narzędzie
`edit` pozwala zmienić dowolny plik. **Sprawdzanie, czy agent trzymał się swojego katalogu,
jest częścią ćwiczenia** (`git status` po każdym kroku).

## Instalacja w repozytorium projektu

```bash
L=moodtrckr/lancuch-agentow
mkdir -p <repo>/.github/agents <repo>/docs/szablony <repo>/docs/features <repo>/docs/adr <repo>/docs/pr <repo>/issues
cp $L/github/agents/*.agent.md <repo>/.github/agents/
cp $L/szablony/*.md <repo>/docs/szablony/
cp moodtrckr/szablony/commit/commit-instructions.md <repo>/.github/
```

Agenta wybierasz z listy agentów w Copilot Chat. Po zakończeniu kroku pod odpowiedzią pojawia się
przycisk następnego kroku (np. „2 · Utwórz issue”).

## Przykładowy przebieg na Mood Trackerze

Funkcja do ćwiczenia: **„Uczestnik chce usunąć swoje konto i dane”** (prawo do usunięcia danych).
Dotyka API, bazy na serwerze, bazy na urządzeniu, tokenów i prywatności — dobra na cały łańcuch.
Przykład ćwiczeniowy, niezależny od briefów C01–C07.

| Krok | Co wpisać / zrobić | Na co patrzeć |
|------|--------------------|---------------|
| 1 | Agent `odkrywca`: „Koordynatorka badania mówi, że uczestnicy pytają, jak usunąć swoje dane z aplikacji.” Odpowiadaj jak koordynatorka. | Czy pyta o potrzebę (kto, kiedy, jakie dane, co z kopią w telefonie), zanim zaproponuje przycisk „Usuń konto”? Czy sprawdził kod? |
| 2 | Przycisk „2 · Utwórz issue”. | Czy kryteria są testowalne? Czy jest „poza zakresem”? Czy ryzyko dotyczy osoby (np. usunięcie cudzego konta)? |
| 3 | Przycisk „3 · Dyskusja architektoniczna”. Wybierz wariant. | Czy rozważył dane na urządzeniu (sqflite) i tokeny, nie tylko serwer? Czy jest wariant „poza aplikacją” (np. prośba do koordynatorki)? |
| 4 | Przycisk „4 · Implementacja”. Zaakceptuj plan, potem zmianę. | Czy trzymał się ADR? Nowe zależności? Zmiany w uwierzytelnianiu bez zgody? |
| 5 | Przycisk „5 · Testy jednostkowe”. | Czy test na „cudzy użytkownik nie może usunąć konta” istnieje i **nie przechodzi**, gdy odwrócić warunek? |
| 6 | Przycisk „6 · Testy integracyjne”. | Czy po usunięciu konta wpisy znikają z bazy? Czy test używa osobnej bazy? Co jest oznaczone jako nieobjęte? |
| 7 | Przycisk „7 · Dokumentacja”. | Czy opis PR ma ślad: odkrycie → issue → ADR → commit → test? Czy „nie sprawdzono” jest wypełnione? |

Po każdym kroku: `git status --short` — czy agent zmienił tylko swoje pliki?
Commit po krokach 4–7 według szablonu `moodtrckr/szablony/commit/`.

## Czego uczy łańcuch

- **Podział odpowiedzialności**: każdy agent ma jedno zadanie i ogranicza go zakres plików.
- **Artefakty zamiast pamięci czatu**: kolejny agent czyta pliki (odkrycie, issue, ADR), nie rozmowę.
  Dzięki temu łańcuch można przerwać i podjąć jutro albo przekazać innej osobie.
- **Człowiek w pętli**: przycisk nie wysyła promptu sam; decyzje (kryteria, wariant, przyjęcie zmiany)
  podejmuje człowiek.
- **Traceability**: od potrzeby do testu — to samo, czego wymaga `mh-iec62304-traceability`.

## Warianty ćwiczenia

- **Łańcuch bez kroku 1**: zacznij od „Dodaj przycisk Usuń konto” u agenta `developer`. Porównaj wynik.
- **Zamiana ról**: para wykonuje krok 3 sama, agent `architekt` recenzuje ich ADR.
- **Przerwany łańcuch**: krok 4 robi jedna para, kroki 5–7 druga, tylko na podstawie plików w repo.

Źródło składni: https://code.visualstudio.com/docs/agent-customization/custom-agents (handoffs).
