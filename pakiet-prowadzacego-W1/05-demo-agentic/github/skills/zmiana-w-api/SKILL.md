---
name: zmiana-w-api
description: Wprowadź małą zmianę w serwerze FastAPI (nowy lub zmieniony endpoint) z planem, testem serwera i ręcznym sprawdzeniem. Użyj przy każdym zleceniu dotyczącym mood-tracker-api.
---

# Zmiana w API

## Kroki

1. **Pytania przed pracą.** Jeśli zlecenie da się zrozumieć na dwa sposoby, zapytaj, zanim
   cokolwiek zmienisz. Zapytaj też, kto potrzebuje tej zmiany, jeśli nie wynika to ze zlecenia.
2. **Plan.** Wypisz pliki do zmiany i powód. Poczekaj na akceptację.
3. **Test najpierw.** Napisz test w `mood-tracker-api/tests/` z `fastapi.testclient.TestClient`,
   który sprawdza dokładny kształt odpowiedzi (nazwy pól i wartości). Uruchom go i pokaż,
   że nie przechodzi. Jeśli brakuje `pytest` lub `httpx`, zatrzymaj się i zapytaj o zgodę.
4. **Zmiana.** Najmniejsza, która spełnia test. Bez zmian poza zakresem.
5. **Sprawdzenie.** Uruchom test (pokaż wynik), wywołaj endpoint `curl` (pokaż odpowiedź),
   sprawdź, że `GET /` nadal zwraca `"status": "ok"`.
6. **Raport.**

## Format raportu

```
Zmienione pliki: <lista>
Test: <nazwa> — przed zmianą: FAIL, po zmianie: PASS (<wynik>)
curl: <polecenie> → <odpowiedź>
Nie sprawdzono: <lista>
Decyzja do podjęcia przez człowieka: <przyjąć / poprawić / odrzucić i dlaczego>
```

Uwaga: testy Fluttera (`flutter test`) nie wywołują serwera i nie są dowodem dla zmian w API.
