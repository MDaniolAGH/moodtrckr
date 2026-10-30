# Business Analyst — zestaw skilli

Dziewięć małych skilli uczących zasad analizy biznesowej. Każdy opisuje **zasadę**, kroki,
format wyniku i kryterium „gotowe”. Nie zawierają odpowiedzi do żadnego scenariusza — każda
grupa stosuje je do swojego klienta (C01–C07).

Instrukcje są po angielsku (dla agenta), wynik powstaje w języku briefu klienta.

## Kolejność wprowadzania

| Etap | Skill | Zasada | Wynik |
|------|-------|--------|-------|
| 0 | `ba-analyst` | Wersja skrócona: wszystkie cztery elementy pierwszej rozmowy naraz | Decyzja, założenia, pytania, obserwacja |
| 1 | `ba-decision-statement` | Najpierw decyzja, potem rozwiązanie | Decyzja w jednym zdaniu |
| 2 | `ba-assumptions` | Fakt ≠ założenie ≠ niewiadoma | Rejestr założeń |
| 3 | `ba-questions` | Pytaj tylko o to, co zmienia rekomendację | 3–5 pytań z wpływem odpowiedzi |
| 4 | `ba-app-observation` | Obserwacja ≠ interpretacja; nie zakładaj błędu | Obserwacja z dowodem |
| 5 | `ba-define-terms` | Spory często dotyczą słów, nie danych | Definicje operacyjne |
| 6 | `ba-stakeholders` | Kto dostarcza, widzi i decyduje — i po co | Mapa interesariuszy i przepływów |
| 7 | `ba-requirements` | Problem przed rozwiązaniem; testowalność; źródło | Wymagania z kryteriami akceptacji |
| 8 | `ba-options` | Porównuj całkowity koszt, w tym zmianę sposobu pracy | Porównanie wariantów |
| 9 | `ba-recommendation` | Odpowiedź na początku; co zmieniłoby zdanie | Rekomendacja na jedną stronę |

Etapy 1–4 dają dokładnie to, czego klient oczekuje przed pierwszą rozmową
(decyzja, założenia, 3–5 pytań, jedna obserwacja z aplikacji).

## Które skille są szczególnie ważne dla którego klienta

Wszystkie grupy przechodzą przez wszystkie etapy; poniżej skille, na których dany scenariusz
opiera się najmocniej.

| Klient | Najważniejsze |
|--------|---------------|
| C01 Field Notes | `ba-app-observation`, `ba-options` |
| C02 After Midnight | `ba-define-terms`, `ba-app-observation` |
| C03 First Step | `ba-requirements` (pomysł ≠ wymaganie), `ba-stakeholders` |
| C04 Work and Wellbeing | `ba-stakeholders`, `ba-app-observation` |
| C05 Before the Conversation | `ba-stakeholders`, `ba-options` (zmiana sposobu pracy) |
| C06 Two Sites One Dataset | `ba-define-terms`, `ba-app-observation` |
| C07 Start Small | `ba-options` (koszt całkowity), `ba-recommendation` |

## Uruchomienie w GitHub Copilot

Skopiujcie foldery `ba-*` do `.github/skills/` w repozytorium (każdy jako osobny podfolder).
W Copilot Chat (tryb Agent) wywołanie wprost: `/ba-decision-statement C02`; Copilot może też
załadować skill sam, gdy pytanie pasuje do jego opisu. Pod odpowiedzią rozwińcie
**References**, żeby sprawdzić, czy skill został użyty.

## Jak pracować z agentem

- Agent proponuje, grupa weryfikuje. Każde twierdzenie o aplikacji wymaga dowodu (plik:linia
  lub powtarzalny przebieg na danych syntetycznych).
- Agent nie zna klienta. Odpowiedzi klienta wprowadzacie Wy — agent nie może ich zgadywać.
- Ceny i informacje rynkowe zawsze ze źródłem i datą.
- Wyłącznie dane syntetyczne.
