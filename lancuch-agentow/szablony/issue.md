# ISSUE-<NNN>: <tytuł w trybie rozkazującym>

Status: otwarte · Priorytet: Must | Should | Could · Źródło: docs/features/<plik>.md

## Kontekst

<1–3 zdania: potrzeba i dla kogo.>

## Zakres

- W zakresie: <…>
- Poza zakresem: <…>

## Kryteria akceptacji

1. Given <kontekst>, when <działanie>, then <obserwowalny wynik>.
2. …

## Wymagania niefunkcjonalne

- Bezpieczeństwo / prywatność: <np. tylko właściciel danych; brak danych w logach>
- Wydajność / niezawodność: <jeśli dotyczy>

## Ryzyka

| ID | Ryzyko dla osoby | Kontrola | Weryfikacja |
|----|------------------|----------|-------------|

## Definition of Done

- [ ] Testy jednostkowe dla każdego kryterium akceptacji
- [ ] Test integracyjny ścieżki end-to-end (API)
- [ ] `flutter analyze` i `flutter test` przechodzą; `pytest` przechodzi
- [ ] Dokumentacja i CHANGELOG zaktualizowane
- [ ] Commit(y) z `Refs: ISSUE-<NNN>`

## Powiązania

ADR: <ADR-NNN> · Commity: <hash> · PR: <opis>
