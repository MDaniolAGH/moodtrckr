---
name: opisz-przeplyw
description: Opisz, którędy przechodzą dane w aplikacji (np. zapis lub odczyt samoopisu) — krok po kroku, z plikiem i linią przy każdym kroku, z oddzieleniem faktów od hipotez. Użyj, gdy ktoś pyta „jak działa…”, „gdzie zapisuje się…”, „skąd się bierze…”.
---

# Opis przepływu danych

Pracuj wyłącznie w trybie odczytu. Nie zmieniaj plików.

## Kroki

1. Ustal punkt startowy (ekran, endpoint, funkcja) i punkt końcowy (baza, ekran, odpowiedź API).
2. Idź po wywołaniach od startu do końca. Przy każdym kroku otwórz plik i przeczytaj funkcję.
3. Zaznacz rozgałęzienia: co dzieje się przy błędzie, braku sieci, braku danych.
4. Oddziel to, co widzisz w kodzie, od tego, co przypuszczasz.

## Format odpowiedzi

```
Przepływ: <start> → <koniec>

| # | Krok | Plik:linia | Fakt / hipoteza |
|---|------|------------|-----------------|

Rozgałęzienia (błąd, brak sieci, brak danych):
- <warunek> → <co się dzieje> (<plik:linia>)

Granice sprawdzenia:
- <czego nie sprawdzono, np. nie uruchomiono aplikacji>
```

Każdy wiersz tabeli ma plik i linię. Jeśli kroku nie da się wskazać w kodzie, wpisz „hipoteza”.
