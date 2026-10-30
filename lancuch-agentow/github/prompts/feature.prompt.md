---
name: feature
description: Rozpocznij pracę nad funkcją według łańcucha odkrycie → issue → ADR → kod → testy → dokumentacja
agent: odkrywca
argument-hint: "[zgłoszenie funkcji w jednym zdaniu]"
---

Zgłoszenie funkcji: ${input:request:Opisz zgłoszenie w jednym zdaniu}

Rozpocznij od kroku 1 łańcucha (odkrycie). Najpierw zapytaj o potrzebę: kto, w jakiej sytuacji,
co dziś robi i co jest problemem. Nie proponuj rozwiązania, dopóki potrzeba nie zostanie
potwierdzona przez użytkownika.

Wynik zapisz w `docs/features/` według szablonu `docs/szablony/discovery.md`, a na końcu
zaproponuj przejście do kroku 2 (utworzenie issue).
