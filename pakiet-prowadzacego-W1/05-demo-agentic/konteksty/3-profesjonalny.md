# Mood Tracker — kontekst dla agenta

Prototyp przejęty od poprzedniego zespołu. Zachowanie aplikacji nie jest zweryfikowane:
twierdzenia o nim wymagają dowodu z kodu lub uruchomienia.

## Struktura

```
mood-tracker-api/        FastAPI + SQLAlchemy + SQLite + JWT
  app/main.py            aplikacja FastAPI (`app`), rejestracja routerów, GET /
  app/routers/           auth_router.py (/auth/*), mood_router.py (/moods/*)
  app/models.py          tabele users, mood_entries
  scripts/               seed_synthetic_data.py (dane syntetyczne)
mood_tracker/            Flutter: Riverpod, sqflite, http, flutter_secure_storage
  lib/services/          klient API i uwierzytelnianie
  lib/data/              lokalna baza (sqflite) i repozytorium
  test/                  testy jednostkowe, widgetów i golden (mocki HTTP)
```

## Polecenia

| Cel | Polecenie |
|-----|-----------|
| Serwer API | `cd mood-tracker-api && source venv/bin/activate && uvicorn app.main:app --reload` |
| Analiza Fluttera | `cd mood_tracker && flutter analyze` |
| Testy Fluttera | `cd mood_tracker && flutter test` |
| Ręczne sprawdzenie API | `curl http://127.0.0.1:8000/<ścieżka>` lub http://127.0.0.1:8000/docs |

**Serwer API nie ma testów automatycznych.** Testy Fluttera używają mocków HTTP i nie wywołują
serwera, więc nie sprawdzają żadnej zmiany w `mood-tracker-api/`.

## Definition of Done

1. Zmiana mieści się w zakresie zlecenia; diff nie zawiera nic poza nim.
2. Zmiana w API: pokaż wynik rzeczywistego wywołania (curl) i zaproponuj test serwera
   (`pytest` + `fastapi.testclient`). Jeśli wymaga to nowej zależności, zatrzymaj się i zapytaj.
3. Zmiana we Flutterze: `flutter analyze` i `flutter test` przechodzą; pokaż wynik.
4. Raport: lista zmienionych plików, wyniki sprawdzeń, czego nie sprawdzono.

## Nigdy

- Nie używaj prawdziwych danych osobowych ani zdrowotnych; tylko dane syntetyczne.
- Nie zmieniaj modeli danych, uwierzytelniania ani istniejących endpointów bez wyraźnego polecenia.
- Nie dodawaj zależności bez pytania.
- Nie wyłączaj testów ani ostrzeżeń analizatora, żeby coś przeszło.

## Sposób pracy

- Przed zmianą przedstaw plan: pliki i powód.
- Twierdzenia o kodzie podawaj z plikiem i linią; oddziel fakty od hipotez.
- Jeśli zlecenie jest niejednoznaczne (np. której „wersji” dotyczy), zapytaj przed pracą.
- W API istnieje już `version="1.0.0"` w `app/main.py`; aplikacja mobilna ma własną wersję
  w `mood_tracker/pubspec.yaml`. Nie twórz trzeciego źródła wersji.
