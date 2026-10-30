# Przykład: profesjonalny kontekst dla agenta

Wzorcowe pliki dla **innego, fikcyjnego projektu** (PostOp Companion: dziennik rekonwalescencji
po zabiegu, Flutter + FastAPI + PostgreSQL). Nie kopiujcie ich do Mood Trackera — pokazują
*budowę* dobrego kontekstu, a Wasz plik musi opisywać Wasz projekt.

```
AGENTS.md                         kontekst projektu (Copilot czyta go z katalogu głównego repo)
github/skills/verify-claim/       sprawdź twierdzenie o kodzie: dowód = plik:linia lub wynik polecenia
github/skills/test-first-fix/     naprawa błędu: najpierw test, który pada, potem najmniejsza poprawka
github/skills/pr-review/          przegląd PR: poprawność, testy, bezpieczeństwo, dane zdrowotne
```

## Słaby a dobry kontekst

| Słaby („You are a Flutter expert…”) | Dobry (AGENTS.md powyżej) |
|---|---|
| Rola i przymiotniki | Dokładne polecenia: build, test, lint, migracje |
| Brak struktury projektu | Mapa katalogów i warstw |
| „Pisz czysty kod” | Konkretne reguły: offline-first, UTC, brak SQL poza repozytoriami |
| Brak granic | Lista „Never”: dane pacjentów, sekrety, wyłączanie testów |
| Brak kryterium ukończenia | Definition of Done ze sprawdzalnymi krokami |
| Ufa sobie | Każde twierdzenie z plikiem i linią; „nie sprawdziłem” jest dozwolone |

Zasada: agent nie potrzebuje komplementów, tylko informacji, których nie wyczyta z kodu,
oraz sposobu, by sprawdzić własną pracę.

## Skill a AGENTS.md

- **AGENTS.md** — zawsze w kontekście: fakty o projekcie i reguły obowiązujące zawsze.
- **Skill** — ładowany, gdy pasuje do zadania: powtarzalna procedura krok po kroku
  z formatem raportu. Opis (`description`) decyduje, kiedy agent po niego sięgnie.

## Użycie z GitHub Copilot

W prawdziwym projekcie `AGENTS.md` leży w katalogu głównym repo, a skille w `.github/skills/`
(tu: widoczny folder `github/`, żeby nie ukrywał go Finder). Skill można wywołać wprost:
`/verify-claim`, `/test-first-fix`, `/pr-review`. W odpowiedzi Copilota rozwiń **References**,
żeby zobaczyć, czy kontekst i skill zostały dołączone.
