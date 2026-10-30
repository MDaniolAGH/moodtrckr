# Scenariusz demo — wykład 1, slajdy 12–23 (90 min)

Narzędzie: GitHub Copilot w VS Code (Chat, tryb Agent). Kod: commit bazowy studentów `58747273`.
Materiały: `05-demo-agentic/` (sabotaż, konteksty, skille, agenci), prompty w `02-prompty/`, role w `03-role/`, karty w `04-do-druku/`.

---

## 0. Przygotowanie (wieczór przed / 30 min przed zajęciami)

Najpierw automatyczna próba: `05-demo-agentic/sabotaz/test_sabotazu.sh` → oczekiwane `7/7 checks`.

```bash
# kopia demo poza SynologyDrive (z lokalnego repo; repo na GitHubie zostało usunięte)
git clone "$HOME/SynologyDrive/AGH/Dydaktyka/Aplikacje Mobilne w Chirurgii/2026/moodtracker-handover" ~/dev/demo-agentic
cd ~/dev/demo-agentic
git checkout 58747273 && git switch -c demo/version-endpoint
git log --oneline -1                      # musi pokazać: 5874727 Mood Tracker R0 handover

# serwer API
cd mood-tracker-api
python3 -m venv venv && venv/bin/pip install -r requirements.txt
venv/bin/python scripts/seed_synthetic_data.py

# Flutter: pobranie zależności i pierwsza kompilacja testów (żeby na zajęciach szło szybko)
cd ../mood_tracker && flutter pub get && flutter test      # oczekiwane: +28: All tests passed!
```

Zmienne do skopiowania w każdym nowym terminalu:

```bash
M="$HOME/SynologyDrive/AGH/Dydaktyka/Aplikacje Mobilne w Chirurgii/2026/pakiet-prowadzacego-W1/05-demo-agentic"
D=~/dev/demo-agentic
```

Checklista przed wejściem na salę:

- [ ] VS Code otwarty na `~/dev/demo-agentic`, czcionka edytora i terminala ≥ 18 pt
- [ ] W repo **nie ma** `.github/copilot-instructions.md` ani `AGENTS.md` (`ls -a $D $D/.github`)
- [ ] Copilot Chat zalogowany, tryb **Agent**, nowa sesja
- [ ] Terminal 1: serwer działa (`cd $D/mood-tracker-api && venv/bin/uvicorn app.main:app --reload`)
- [ ] Terminal 2: wolny, w katalogu `$D`
- [ ] Wariant awaryjny: zrzut ekranu z próby generalnej + `sabotaz/version-endpoint.patch`
- [ ] 7 kartek do losowania: tytuł briefu + imię klienta (C01 Ewa, C02 Tomasz, C03 Marta,
      C04 Joanna, C05 Lena, C06 Marek, C07 Zofia)

---

## 1. Plan zajęć

| Min | Slajd | Blok |
|-----|-------|------|
| 0–3 | 12 | Głosowanie otwierające |
| 3–12 | 12 | Pytania przed pracą + przewidywania |
| 12–22 | 12 | Pokaz: plan → wykonanie → diff → curl |
| 22–27 | 12 | **Sabotaż** |
| 27–33 | 13–14 | Umiejętności i mapa kursu |
| 33–38 | 15–16 | Stakeholders |
| 38–46 | 17 | „Potrzeba czy funkcja?” |
| 46–56 | 18–19 | „Wyrób medyczny czy nie?” + rodzaje dowodów |
| 56–60 | 20–21 | Przypadek poradni |
| 60–75 | 22 | Ćwiczenie discovery + klient na żywo |
| 75–85 | 23 | Losowanie klientów + działająca aplikacja |
| 85–90 | 23 | Exit ticket |

---

## 2. Slajd 12 — pokaz krok po kroku

### 2.1 Głosowanie otwierające (0–3 min)

Powiedz: *„Agent dodał endpoint, wszystkie testy są zielone. Kto przyjmuje zmianę bez dalszego
sprawdzania?”* — **zapisz liczbę rąk na tablicy.** Wrócisz do niej po sabotażu.

### 2.2 Pytania przed pracą (3–8 min)

Pokaż zlecenie ze slajdu. Pytanie do sali: *„Co jest w tym zleceniu niejasne?”*

Po odpowiedziach pokaż w edytorze dwa miejsca:

```bash
grep -n 'version' $D/mood-tracker-api/app/main.py     # 55:    version="1.0.0",
grep -n '^version' $D/mood_tracker/pubspec.yaml       # 5:version: 1.0.0+1
```

Oczekiwane wnioski:
- „Wersja aplikacji” może oznaczać wersję API albo aplikacji mobilnej.
- Nikt nie powiedział, **kto** potrzebuje tego endpointu i po co (decyzja z fazy wymagań).

### 2.3 Przewidywania studentów (8–12 min)

**Dla studentów (kartka lub LMS):**
1. Które pliki zmieni agent?
2. Skąd agent weźmie wartość wersji?
3. Jeśli agent popełni błąd w nazwie pola JSON, czy istniejące testy go wyłapią? (tak / nie)

### 2.4 Plan agenta (12–15 min)

Nowa sesja czatu, tryb Agent (albo wbudowany agent **Plan**, jeśli jest na liście). Prompt:

```
Pracuj w katalogu mood-tracker-api. Dodaj endpoint GET /version w aplikacji FastAPI,
który zwraca JSON z dwoma polami: service (nazwa serwisu) i version (wersja aplikacji,
odczytana z istniejącego miejsca w kodzie, jeśli takie jest). Endpoint nie odczytuje danych
uczestników, nie wymaga uwierzytelnienia i nie dotyka bazy danych. Zakres: wyłącznie nowy
endpoint i jedno zdanie w README. Bez nowych zależności. Nie zmieniaj modeli danych,
schematów, uwierzytelniania ani istniejących endpointów. Zanim zmienisz pliki, przedstaw plan:
które pliki zmienisz i dlaczego. Jeśli potrzebna jest zmiana poza zakresem, zatrzymaj się i zapytaj.
```

Przeczytaj plan na głos. Pytanie do sali: *„Czy plan mieści się w zakresie?”*

**Sprawdź w planie:** czy agent zapytał, o którą wersję chodzi? Jeśli nie — to obserwacja
do omówienia (agent nie zadał pytania, które sala zadała przed chwilą).

### 2.5 Wykonanie i diff (15–19 min)

Napisz w czacie: `Wykonaj plan.` Potem w terminalu 2:

```bash
cd $D && git status --short && git diff
```

Przy każdym zmienionym pliku pytaj salę: *„Czy to w zakresie?”*

**Co sprawdzić w diffie:**

| Pytanie | Dobra odpowiedź |
|---------|-----------------|
| Ile plików? | `app/main.py` (lub nowy router zarejestrowany w `main.py`) + `README.md` |
| Skąd `version`? | z `app.version` (jedno źródło), a nie nowy napis `"1.0.0"` |
| Nowe zależności? | brak zmian w `requirements.txt` |
| Zmiany w modelach / auth / innych endpointach? | brak |
| Wymaga logowania? | nie (brak `Depends(get_current_user)`) |

Porównaj z przewidywaniami studentów z 2.3 (pytania 1 i 2).

### 2.6 Niezależne sprawdzenie (19–22 min)

```bash
curl -s http://127.0.0.1:8000/version
curl -s http://127.0.0.1:8000/          # nadal {"status":"ok", ...}
```

Lub w przeglądarce: http://127.0.0.1:8000/docs → `GET /version` → *Try it out*.

Decyzja na głos: przyjąć / poprawić / odrzucić. Powiedz, czego pokaz **nie** udowodnił:
że ktokolwiek potrzebuje tego endpointu.

Po decyzji „przyjąć” zatwierdź zmianę — dzięki temu diff sabotażu w 2.7 pokaże czytelną parę
`-version` / `+versoin` zamiast całego nowego endpointu:

```bash
cd $D && git commit -am "Add GET /version"
```

### 2.7 Sabotaż (22–27 min)

Na oczach sali, w edytorze, w funkcji endpointu zmień klucz `"version"` na `"versoin"`
i zapisz plik (serwer z `--reload` przeładuje się sam). Pokaż diff:

```bash
git diff mood-tracker-api/app/main.py | grep '^[-+] '
```

Najpierw przewidywanie: *„Czy testy to wyłapią?”* (porównaj z odpowiedzią z 2.3, pytanie 3). Potem:

```bash
cd $D/mood_tracker && flutter test        # oczekiwane: +28: All tests passed!
curl -s http://127.0.0.1:8000/version     # {"service":"Mood Tracker API","versoin":"1.0.0"}
```

Wróć do liczby rąk z 2.1: *„Kto teraz przyjmuje zmianę?”*

Wyjaśnienie (30 s):
1. Serwer API nie ma ani jednego testu — nowy kod nie jest wykonywany przez żaden test.
2. 28 testów Fluttera używa mocków (`MockAuthService`, `MockHttpClient`) — nie łączą się z serwerem.
3. „Istniejące testy przechodzą” jest prawdą i niczego nie mówi o nowym zachowaniu.

Opcjonalnie (+2 min) — test, który wyłapuje błąd:

```bash
cd $D/mood-tracker-api && venv/bin/pip install -q pytest httpx
mkdir -p tests && cp "$M/sabotaz/test_version.py" tests/
venv/bin/python -m pytest -q tests        # FAILED: Left contains 1 more item: {'versoin': '1.0.0'}
```

Pytanie do sali: *„Jakie kryterium akceptacji napisalibyście teraz?”*
Oczekiwane: test, który wywołuje `GET /version` i sprawdza nazwy pól i wartość.
Dopytaj: *„Czy `pytest` to nowa zależność? Czy mieści się w zakresie zlecenia?”*

### Wariant awaryjny (Copilot lub sieć zawodzi)

```bash
cd $D && git reset --hard 58747273 && rm -rf mood-tracker-api/tests mood-tracker-api/.pytest_cache
git apply "$M/sabotaz/version-endpoint.patch"      # gotowy, poprawny endpoint
git diff                                           # omów diff jak w 2.5
git commit -qam "Add GET /version"                 # decyzja: przyjąć
git apply "$M/sabotaz/sabotaz.patch"               # sabotaż: git diff pokaże -version / +versoin
```

Między `git commit` a `git apply ... sabotaz.patch` odczekaj co najmniej sekundę (np. omów diff).
Sabotaż nie zmienia długości pliku; zapisany w tej samej sekundzie co poprzednia zmiana zostaje
zignorowany przez cache bajtkodu Pythona i serwer nadal zwraca `"version"`. Jeśli tak się stanie:
`touch mood-tracker-api/app/main.py` i odśwież `curl`.

Powiedz wprost, że pokazujesz przygotowaną zmianę, a nie wynik agenta na żywo.

### Reset po pokazie

```bash
cd $D && git reset --hard 58747273 && rm -rf mood-tracker-api/tests mood-tracker-api/.pytest_cache
```

`git clean -fd` nie wystarczy: w `tests/` zostaje ignorowany `__pycache__` i folder nie znika.
Baza danych z danymi syntetycznymi (`mood_tracker.db`) i `venv` zostają — tak ma być.

---

## 3. Slajdy 13–23 — interakcje

### Slajdy 13–14 (27–33 min)
Pytanie: *„Które z sześciu umiejętności użyliśmy w pokazie?”* Oczekiwane: delegowanie
(zakres, warunek przerwania), weryfikacja (diff, curl, sabotaż), rozumienie systemu (dwie wersje,
brak testów API), rozpoznanie problemu (kto potrzebuje endpointu).

### Slajdy 15–16 (33–38 min)
Zanim pokażesz slajd 16: *„Kto jest zainteresowany podsumowaniem samoopisów pacjenta?”*
Zbierz role na tablicy, potem pokaż slajd. *„Kogo najrzadziej się pyta, a kto ponosi skutki?”*

### Slajd 17 — „Potrzeba czy funkcja?” (38–46 min)
Czytaj po jednym; sala: kciuk w górę = potrzeba, w dół = funkcja.

| Zdanie | Odpowiedź |
|--------|-----------|
| Dashboard z wykresami | funkcja |
| Mniej telefonów do koordynatorki | potrzeba |
| Powiadomienia push o 20:00 | funkcja |
| Wiedzieć, czy uczestnik w ogóle wypełnia wpisy | potrzeba |
| Eksport do CSV | funkcja |
| Porównywalne wyniki z dwóch ośrodków | potrzeba |

Przy każdej funkcji dopytaj: *„Jaka potrzeba może za nią stać?”*

### Slajdy 18–19 — „Wyrób medyczny czy nie?” (46–56 min)
Ta sama aplikacja, cztery warianty; głosowanie: tak / nie / zależy.

1. Lista wpisów uczestnika.
2. Średni nastrój tygodniowo, czytany przez badacza.
3. Alert do psychologa po 3 dniach z nastrojem poniżej 3.
4. Aplikacja sugeruje uczestnikowi kontakt z lekarzem.

Rozstrzygnięcie: o kwalifikacji decydują przeznaczenie i funkcja oprogramowania (notatka do slajdu 18),
nie etykieta „badawczy”. Wariant 3 zostaw jako sporny — to zamierzone.

Przy slajdzie 19 wróć do sabotażu: *„28 zielonych testów — jaki to rodzaj dowodu? Dla czego?”*
Oczekiwane: techniczny, i to tylko dla aplikacji mobilnej.

### Slajdy 20–21 (56–60 min)
Bez zmian względem notatek.

### Slajd 22 — ćwiczenie + klient na żywo (60–75 min)
4 min samodzielnie, 4 min w parach (jak w notatkach). Potem 3–4 pary czytają swoje pytanie.
**Na najlepsze pytanie odpowiedz jako klient** faktem, który zmienia zakres, np.:
- *„Kto czyta zestawienie?”* → „Fizjoterapeuta, 2 minuty przed wizytą, na telefonie.”
- *„Kto jeszcze widzi samoopisy?”* → „Sponsor chce comiesięczny raport z danymi pacjentów.”
- *„Co, gdy brakuje wpisu?”* → „Koordynatorka dzwoni do pacjenta, ale ma na to godzinę tygodniowo.”

Pytanie do sali: *„Co zmieniła ta odpowiedź w zakresie prototypu?”*

### Slajd 23 — losowanie i aplikacja (75–90 min)
1. Każda para losuje kartkę: tytuł briefu + imię klienta. Nic więcej — brief przeczytają przed L1.
2. Pokaż działającą aplikację: login `p01@study.example` / `demo1234`, dodaj wpis.
   *„To przejmujecie. Nikt z poprzedniego zespołu nie odpowie na wasze pytania.”*
3. Exit ticket (2 min): *„Co muszę ustalić przed rozpoczęciem implementacji?”*

---

## 4. Co studenci sprawdzają sami — podsumowanie

| Moment | Zadanie dla studentów | Na co patrzysz |
|--------|-----------------------|----------------|
| 2.2 | Co jest niejasne w zleceniu? | Czy ktoś wskaże dwie wersje lub „kto tego potrzebuje” |
| 2.3 | Przewidywania: pliki, źródło wersji, czy testy wyłapią błąd | Odsetek „tak” w pytaniu 3 — wrócisz do niego |
| 2.5 | „Czy to w zakresie?” przy każdym pliku diffu | Czy pytają o źródło wartości i zależności |
| 2.7 | Kryterium akceptacji po sabotażu | Czy kryterium wykonuje nowy kod i sprawdza dokładny wynik |
| 17 | Potrzeba czy funkcja | Czy potrafią podać potrzebę za funkcją |
| 18 | Wyrób medyczny czy nie | Czy uzasadniają przeznaczeniem, nie etykietą |
| 22 | Jedna decyzja, dwa założenia, trzy pytania | Czy pytanie zmienia zakres |
| 23 | Exit ticket | Czy odróżniają potrzebę od funkcji |
