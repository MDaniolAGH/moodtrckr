# Ściągawka prowadzącego — W1, slajdy 12–23

Jedna strona na zajęcia. Szczegóły: `01-SCENARIUSZ.md`. Prompty: `02-prompty/prompty.md`.

---

## 1. Kopia demo na nowym komputerze (z pliku, bez sieci i logowania)

Kod demo jest w `06-kod-demo/moodtracker-demo.bundle` (pełna historia, commit bazowy `58747273`).
Polecenia zakładają, że repo `moodtrckr` leży w `~/dev/moodtrckr` (Windows: `$HOME\dev\moodtrckr`)
i że uruchamiasz je z katalogu `~/dev`. Po pobraniu ZIP-em z GitHuba zmień nazwę folderu
`moodtrckr-main` na `moodtrckr`.

**macOS / Linux**

```bash
git clone moodtrckr/pakiet-prowadzacego-W1/06-kod-demo/moodtracker-demo.bundle ~/dev/demo-agentic
cd ~/dev/demo-agentic && git checkout 58747273 && git switch -c demo/version-endpoint
cd mood-tracker-api && python3 -m venv venv && venv/bin/pip install -r requirements.txt
venv/bin/python scripts/seed_synthetic_data.py
cd ../mood_tracker && flutter pub get && flutter test
```

**Windows (PowerShell)**

```powershell
git clone moodtrckr\pakiet-prowadzacego-W1\06-kod-demo\moodtracker-demo.bundle $HOME\dev\demo-agentic
cd $HOME\dev\demo-agentic; git checkout 58747273; git switch -c demo/version-endpoint
cd mood-tracker-api; py -3 -m venv venv; venv\Scripts\pip install -r requirements.txt
venv\Scripts\python scripts\seed_synthetic_data.py
cd ..\mood_tracker; flutter pub get; flutter test
```

Oczekiwane: `+28: All tests passed!`

---

## 2. Komendy w trakcie pokazu

| Krok | macOS | Windows (PowerShell) |
|------|-------|----------------------|
| Start API (terminal 1, zostaw otwarty) | `cd ~/dev/demo-agentic/mood-tracker-api && venv/bin/uvicorn app.main:app --reload` | `cd $HOME\dev\demo-agentic\mood-tracker-api; venv\Scripts\uvicorn app.main:app --reload` |
| Dwie wersje (2.2) | `grep -n version mood-tracker-api/app/main.py mood_tracker/pubspec.yaml` | `Select-String version mood-tracker-api\app\main.py, mood_tracker\pubspec.yaml` |
| Co zmienił agent | `git status --short && git diff` | to samo |
| Sprawdzenie endpointu | `curl -s http://127.0.0.1:8000/version` | `curl.exe -s http://127.0.0.1:8000/version` |
| Health check | `curl -s http://127.0.0.1:8000/` | `curl.exe -s http://127.0.0.1:8000/` |
| Przyjęcie zmiany | `git commit -am "Add GET /version"` | to samo |
| Sabotaż | w edytorze: `"version"` → `"versoin"`, Cmd+S | to samo, Ctrl+S |
| Diff sabotażu | `git diff \| grep '^[-+] '` | `git diff \| Select-String '^[-+] '` |
| Testy Fluttera | `cd mood_tracker && flutter test` | `cd mood_tracker; flutter test` |
| Reset | `git reset --hard 58747273 && rm -rf mood-tracker-api/tests mood-tracker-api/.pytest_cache` | `git reset --hard 58747273; Remove-Item -Recurse -Force mood-tracker-api\tests, mood-tracker-api\.pytest_cache -ErrorAction SilentlyContinue` |

Swagger w przeglądarce: http://127.0.0.1:8000/docs → `GET /version` → *Try it out*.

Test serwera (opcjonalnie, po sabotażu):

```bash
cd mood-tracker-api && venv/bin/pip install pytest httpx
mkdir -p tests && cp ../../moodtrckr/pakiet-prowadzacego-W1/05-demo-agentic/sabotaz/test_version.py tests/
venv/bin/python -m pytest -q tests      # oczekiwane: 1 failed, 1 passed
```

---

## 2a. Automatyczna próba sabotażu (przed zajęciami, ~40 s)

```bash
moodtrckr/pakiet-prowadzacego-W1/05-demo-agentic/sabotaz/test_sabotazu.sh
```

Buduje tymczasową kopię z `06-kod-demo/moodtracker-demo.bundle`, dodaje endpoint, robi sabotaż
i sprawdza 7 warunków (curl przed i po, diff, `flutter test` 28/28, `pytest` 1 failed). Nie rusza
`~/dev/demo-agentic`. Wynik `7/7 checks` = pokaz zachowa się zgodnie z planem. Tylko macOS/Linux.

## 3. Copilot — gdzie co jest

| Potrzebuję | Gdzie |
|------------|-------|
| Tryb agenta | Chat → lista trybów pod polem wpisywania → **Agent** |
| Nowa sesja (czysta pamięć) | przycisk **+** w nagłówku czatu |
| Zmiana modelu | lista modeli pod polem wpisywania |
| Własny agent (eksplorator, recenzent) | lista agentów w polu czatu (wymaga `.github/agents/`) |
| Co agent przeczytał (instrukcje, skille) | rozwiń **References** pod odpowiedzią |
| Przyjąć / cofnąć zmiany agenta | **Keep** / **Undo** w panelu zmian |
| Skill wprost | `/nazwa-skilla` w polu czatu |

---

## 4. Fakty, na których opiera się pokaz (sprawdzone)

- `mood-tracker-api/app/main.py:55` → `version="1.0.0"` (wersja API)
- `mood_tracker/pubspec.yaml:5` → `version: 1.0.0+1` (wersja aplikacji mobilnej)
- W `mood-tracker-api/` **nie ma żadnego testu**.
- 28 testów Fluttera używa mocków (`MockAuthService`, `MockHttpClient`) — nie łączą się z serwerem.
- Próba z Copilotem (bez kontekstu): **nie zapytał o wersję**, wziął `app.version`, dopisał jedno
  zdanie do `mood-tracker-api/README.md` (nie zapytał, które z trzech README).
- Po sabotażu: `flutter test` → 28/28 zielone; `curl` → `"versoin"`; `pytest` → FAIL.

Konto testowe w aplikacji: `p01@study.example` / `demo1234`.

---

## 5. Gdy coś nie działa

| Objaw | Co zrobić |
|-------|-----------|
| Copilot nie odpowiada / brak sieci | Wariant awaryjny: `git reset --hard 58747273`, `git apply .../sabotaz/version-endpoint.patch`, omów diff, `git commit -am "Add GET /version"`, `git apply .../sabotaz/sabotaz.patch`. Powiedz wprost, że to przygotowana zmiana. |
| Copilot od razu pisze kod, bez planu | Też dobry materiał: „Prosiliśmy o plan. Co to mówi o zaufaniu do agenta?” Cofnij **Undo** i wyślij: „Najpierw plan, bez zmian w plikach.” |
| Copilot zmienia więcej plików niż trzeba | Najlepszy możliwy materiał na pytanie „czy to w zakresie?”. Odrzuć zmianę na głos. |
| Po sabotażu `curl` nadal pokazuje `"version"` | Zmiana o tej samej długości zapisana w tej samej sekundzie co poprzednia — Python używa starego `.pyc`. Odczekaj chwilę, zapisz plik jeszcze raz (albo `touch mood-tracker-api/app/main.py`), w razie potrzeby zrestartuj uvicorn. Przy ręcznej edycji praktycznie się nie zdarza; dotyczy głównie wariantu awaryjnego z dwoma patchami jeden po drugim. |
| `curl` nie odpowiada | Czy terminal 1 z uvicorn działa? Port zajęty: `lsof -i :8000` (Windows: `netstat -ano \| findstr :8000`) |
| `/version` zwraca 404 po zmianie | Serwer uruchomiony bez `--reload` → zrestartuj (Ctrl+C, start jeszcze raz) |
| `git diff` po sabotażu pokazuje cały endpoint | Nie zrobiłeś commita po „przyjąć” → w edytorze cofnij `"versoin"` na `"version"`, `git commit -am "Add GET /version"`, zrób sabotaż jeszcze raz |
| `flutter test` trwa długo | Pierwsze uruchomienie kompiluje; przed zajęciami uruchom raz. Na zajęciach ~3 s. |
| Czerwony błąd Gradle w VS Code („major version 69”) | Rozszerzenia Java/Gradle — nie dotyczy Fluttera. Ignoruj albo wyłącz je dla workspace. |
| VS Code wybiera iPhone'a („enable Developer Mode”) | Kliknij nazwę urządzenia w pasku stanu → wybierz emulator lub macOS |
| Brak Fluttera na komputerze | Pomiń `flutter test`; pokaż wynik z sekcji 4 i ten plik jako dowód z próby |

---

## 6. Slajdy w jednym zdaniu (gdy się zatniesz)

| Slajd | Pytanie do sali | Wniosek |
|-------|-----------------|---------|
| 12 | „Kto przyjmuje zmianę, skoro testy są zielone?” | Zielone testy sprawdzają tylko kod, który wykonują. |
| 13 | „Której umiejętności użyliśmy przed chwilą?” | Umiejętności przetrwają zmianę narzędzi. |
| 14 | „Który etap jest dla was nietypowy?” | Ocenia się decyzję i dowody, nie liczbę funkcji. |
| 15 | „Co musimy ustalić przed implementacją?” | AI przyspiesza wykonanie, nie rozpozna potrzeby. |
| 16 | „Kogo najrzadziej się pyta, a kto ponosi skutki?” | Pacjent i operator. |
| 17 | „Klient chce dashboardu — pierwsze pytanie?” | Do czego i kto go użyje. |
| 18 | „Czy wariant A może być wyrobem medycznym?” | Decyduje przeznaczenie i funkcja, nie etykieta. |
| 19 | „Testy przechodzą — gotowe?” | Dowód techniczny ≠ użytkowy ≠ kliniczny. |
| 20–21 | „Co tu jest faktem, a co założeniem?” | Pomysł sponsora to fakt o zgłoszeniu, nie o potrzebie. |
| 22 | „Co zmieniła odpowiedź klienta?” | Dobre pytanie zmienia zakres. |
| 23 | Exit ticket | „Co muszę ustalić przed implementacją?” |

---

## 7. Gdy brakuje czasu

| Opóźnienie | Co skrócić |
|------------|------------|
| 5 min | Pomiń opcjonalny `pytest`; quiz 17 do 3 zdań |
| 10 min | Slajdy 13–14 jednym zdaniem każdy; quiz 18 tylko wariant 3 |
| 15 min | Ćwiczenie 22: 3+3 min, omówienie 2 par; losowanie bez pokazu aplikacji |

Nie skracaj: sabotażu (2.7) i ćwiczenia discovery (22) — to dwa najważniejsze momenty.
