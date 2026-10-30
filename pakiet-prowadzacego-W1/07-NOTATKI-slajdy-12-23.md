# Notatki do wykładu 1 — slajdy 12–23 (wersja na dziś)

Dla każdego slajdu: tekst slajdu, **oryginalne notatki prowadzącego z `Wyklad_1.pptx`** (przepisane bez zmian) i **zmiany na dziś** — interakcje, sabotaż i wyniki próby z 30.10.2026.
Komendy krok po kroku: `01-SCENARIUSZ.md`. Ściągawka: `00-SCIAGAWKA.md`. Prompty: `02-prompty/prompty.md`.

| Min | Slajd |
|-----|-------|
| 0–27 | 12 — pokaz + sabotaż |
| 27–33 | 13–14 |
| 33–38 | 15–16 |
| 38–46 | 17 |
| 46–56 | 18–19 |
| 56–60 | 20–21 |
| 60–75 | 22 |
| 75–90 | 23 |

---

## Slajd 12 · Demonstracja AI-assisted development na Mood Trackerze

### Na slajdzie

- 43–48 MIN · POKAZ NA ŻYWO · OSOBNA KOPIA MOOD TRACKERA · PRZYKŁAD TECHNICZNY, NIE WYMAGANIE KLIENTA
- Zadanie dla agenta
- Dodaj do serwera FastAPI endpoint GET /version, który zwraca nazwę serwisu i wersję aplikacji.
- Zakres: tylko nowy endpoint i dokumentacja, bez nowych zależności.
- Bez zmian w modelach danych, uwierzytelnianiu i dostępie do danych uczestników.
- Kryterium akceptacji: GET /version zwraca JSON z polami service i version; istniejące testy przechodzą.
- Przebieg
- 1
- Plan · agent w trybie odczytu proponuje plan
- 2
- Wykonanie · zmiana w osobnym branchu
- 3
- Przegląd · czytamy diff
- 4
- Sprawdzenie · ręczne wywołanie GET /version
- 5
- Decyzja · przyjąć, poprawić, odrzucić
- Pytanie do was: co trzeba sprawdzić, zanim przyjmiemy zmianę? Czego nie sprawdzają istniejące testy Fluttera? A może pewne pytania należy zadać przed przystąpieniem do jakiejkolwiek pracy?
- Repozytorium: github.com/MDaniolAGH/moodtracker-handover, wersja bazowa  dla studentów: commit 58747273

### Notatki prowadzącego (oryginał)

**Czas i cel**

43–48 min (5 min pokazu). Pokazać cykl z poprzedniego slajdu na rzeczywistym kodzie Mood Trackera: ograniczone zadanie, wykonanie przez agenta, przegląd diffu, niezależne sprawdzenie, decyzja. Zadanie jest neutralne technicznie i nie odpowiada żadnemu briefowi C01–C07.

**Cel dydaktyczny**

Student widzi, jak wygląda dobrze ograniczone zlecenie i dlaczego sprawdzenie wyniku jest osobnym krokiem, którego nie zastępują istniejące testy.

**Wersja kodu i zakres weryfikacji**

Repozytorium: https://github.com/MDaniolAGH/moodtracker-handover. Wersja bazowa studentów: commit 58747273c62075e6d742a5f50d911536899035d2. Przed zajęciami sprawdź, czy nadal pracujesz na tej wersji (git log -1); jeśli na innej, nazwij ją tutaj i w notatkach L1. Pokaz wykonujesz w osobnej kopii lub branchu (np. demo/version-endpoint), nie w wersji bazowej, którą dostają pary. Zakres weryfikacji przy redakcji tych notatek: dostęp był tylko do README (serwer FastAPI + SQLite + JWT; główny endpoint GET / zwraca {"status": "ok", ...}; dokumentacja Swagger pod /docs); pliki mood-tracker-api/app/main.py i app/routers/mood_router.py nie zostały otwarte. Przed pokazem otwórz main.py i sprawdź, gdzie są rejestrowane routery i jak nazwana jest aplikacja FastAPI.

**Dokładny prompt dla agenta**

„Pracuj w repozytorium moodtracker-handover, w katalogu mood-tracker-api, na branchu demo/version-endpoint. Dodaj endpoint GET /version w aplikacji FastAPI, który zwraca JSON z dwoma polami: service (nazwa serwisu, stała) i version (wersja aplikacji, stała w kodzie lub odczytana z istniejącego miejsca, jeśli takie jest). Endpoint nie odczytuje żadnych danych uczestników, nie wymaga uwierzytelnienia i nie dotyka bazy danych. Zakres: wyłącznie nowy endpoint oraz jedno zdanie w README opisujące go. Użyj wyłącznie obecnych zależności z requirements.txt. Nie zmieniaj modeli danych, schematów, uwierzytelniania, konfiguracji bazy ani istniejących endpointów. Zanim zmienisz pliki, przedstaw plan: które pliki zmienisz i dlaczego. Jeśli uznasz, że potrzebna jest zmiana poza tym zakresem, zatrzymaj się i zapytaj.”

**Zakres i kryterium akceptacji**

Zakres: jeden nowy endpoint w istniejącym module (main.py lub osobny router zarejestrowany w main.py) i jedno zdanie w README. Kryterium akceptacji: (1) GET http://127.0.0.1:8000/version zwraca kod 200 i JSON z polami service i version; (2) GET / nadal zwraca status ok; (3) istniejące testy przechodzą; (4) diff nie zawiera zmian poza endpointem i README.

**Sposób sprawdzenia**

Niezależnie od agenta: uruchom serwer (uvicorn app.main:app --reload), wywołaj curl http://127.0.0.1:8000/version albo otwórz http://127.0.0.1:8000/docs i wykonaj endpoint z interfejsu Swagger. Pokaż odpowiedź na ekranie. Powiedz wprost: istniejące testy Fluttera (mood_tracker/test, 28 testów według README) dotyczą aplikacji mobilnej i nie sprawdzają nowego endpointu serwera; test endpointu to osobne sprawdzenie. Jeśli w mood-tracker-api są testy serwera, uruchom je także; jeśli nie ma, nazwij to jako lukę.

**Plan pięciominutowego pokazu**

0:00–0:45 pokaż branch i prompt (slajd); 0:45–2:00 agent w trybie planu: przeczytaj plan na głos, zapytaj salę, czy mieści się w zakresie; 2:00–3:00 wykonanie; 3:00–4:00 diff: pokaż każdy zmieniony plik, pytaj „czy to w zakresie?”; 4:00–4:45 curl lub /docs: odpowiedź endpointu; 4:45–5:00 decyzja i jedno zdanie: co ten pokaz udowodnił, a czego nie (nie udowodnił, że endpoint jest komukolwiek potrzebny).

**Wariant awaryjny**

Jeśli agent lub sieć zawiodą: pokaż przygotowany wcześniej diff (zapisany plik .patch lub commit na branchu demo) i wcześniej nagrane 60–90 s wywołania endpointu. Przygotuj je przed zajęciami. Nie deklaruj, że pokaz był przećwiczony ani że testy przeszły, jeśli tego nie zrobiłeś; te notatki tego nie potwierdzają.

**Pytanie do sali po pokazie**

„Co musicie sprawdzić, zanim przyjmiecie tę zmianę?” Oczekiwane: diff w zakresie, odpowiedź endpointu, istniejące endpointy działają, brak zmian w modelach i uwierzytelnianiu. „Jakiej decyzji nie było w zleceniu?” Oczekiwane: czy ktokolwiek potrzebuje tego endpointu; to decyzja z fazy wymagań.

**Przejście**

„Ten cykl będziecie wykonywać sami. Jakie umiejętności są w nim potrzebne, niezależnie od narzędzia?”

**Źródła**

Repozytorium kursu (README). Przykładowe narzędzie: agent kodujący w trybie planu i wykonania (np. Claude Code; dokumentacja Anthropic). Nazwa narzędzia jest przykładem, nie wymaganiem.

### Zmiany na dziś

**Plan na dziś zamiast 5-minutowego pokazu: 0–27 min.** Pełne kroki i komendy: `01-SCENARIUSZ.md`, sekcja 2.

| Min | Krok | Co mówisz / robisz |
|-----|------|--------------------|
| 0–3 | Głosowanie | „Agent dodał endpoint, wszystkie testy są zielone. Kto przyjmuje zmianę bez dalszego sprawdzania?” — **zapisz liczbę rąk na tablicy**. |
| 3–8 | Pytania przed pracą | „Co jest niejasne w tym zleceniu?” Potem pokaż `main.py:55` (`version="1.0.0"`, wersja API) i `pubspec.yaml:5` (`version: 1.0.0+1`, wersja aplikacji). „O którą wersję chodzi? I kto w ogóle prosił o ten endpoint?” |
| 8–12 | Karta przewidywań | Studenci wypełniają pytania 1–4 (`04-do-druku/karta-przewidywan.md`). |
| 12–15 | Plan agenta | Prompt P1 (`02-prompty/prompty.md`), nowa sesja, tryb Agent. Czytasz plan na głos: „Czy mieści się w zakresie? Czy agent zapytał o wersję?” |
| 15–19 | Wykonanie i diff | `Wykonaj plan.` → `git status --short && git diff`. Przy każdym pliku: „Czy to w zakresie?” |
| 19–22 | Sprawdzenie | `curl -s http://127.0.0.1:8000/version` i `curl -s http://127.0.0.1:8000/`. Decyzja na głos: przyjąć. **`git commit -am "Add GET /version"`** (bez commita diff sabotażu będzie nieczytelny). |
| 22–27 | **Sabotaż** | Na oczach sali w edytorze: `"version"` → `"versoin"`, zapisz. Najpierw pytanie „Czy testy to wyłapią?”, potem `flutter test` → **28/28 zielone**, `curl` → `"versoin"`. Wróć do liczby rąk: „Kto teraz przyjmuje zmianę?” |

**Wynik próby z Copilotem (bez kontekstu, 30.10.2026)** — do opowiedzenia, jeśli na żywo wyjdzie podobnie:
- Agent **nie zapytał**, o którą wersję chodzi — wziął `app.version` (wersję API). Dobre źródło, ale decyzja podjęta po cichu.
- Dopisał zdanie do `mood-tracker-api/README.md` — **nie zapytał, które z trzech README** (główne, API, Fluttera).
- Endpoint bez docstringu — w `/docs` nie ma opisu.
- Zmienione pliki: `app/main.py` (+5 linii), `mood-tracker-api/README.md` (+2 linie). Zmiana zachowana w kopii demo jako tag `exp1-copilot-no-context`.

**Dlaczego sabotaż działa (30 s):**
1. W `mood-tracker-api/` nie ma żadnego testu — nowy kod nie jest wykonywany przez żaden test.
2. 28 testów Fluttera używa mocków (`MockAuthService`, `MockHttpClient`) — nie łączą się z serwerem.
3. „Istniejące testy przechodzą” jest prawdą i niczego nie mówi o nowym zachowaniu.

Opcjonalnie (+2 min): `pytest` z `05-demo-agentic/sabotaz/test_version.py` → `1 failed, 1 passed`, komunikat `Left contains 1 more item: {'versoin': '1.0.0'}`.
Pytanie do sali: **„Jakie kryterium akceptacji napisalibyście teraz?”** Oczekiwane: test wywołujący `GET /version` i sprawdzający nazwy pól i wartość. Dopytaj: czy `pytest` to „nowa zależność” w rozumieniu zlecenia?

**Korekta notatek ze slajdu:** notatki mówią, że `main.py` i `mood_router.py` nie zostały otwarte. Sprawdzone: aplikacja FastAPI to `app` z `title="Mood Tracker API"` i `version="1.0.0"` (`main.py:49,55`); routery rejestrowane w `main.py:81–82`; `GET /` w `main.py:89`; w `mood-tracker-api/` brak testów (potwierdza „nazwij to jako lukę”).

**Uwaga:** adres repozytorium na slajdzie prowadzi teraz do repozytorium prywatnego (404 dla studentów). Usuń go ze slajdu albo zostaw tylko jako ilustrację. Kopia demo: `06-kod-demo/moodtracker-demo.bundle`.

Przed zajęciami: `05-demo-agentic/sabotaz/test_sabotazu.sh` → `7/7 checks` (5 przebiegów z rzędu przeszło 30.10.2026).

Awaria Copilota lub sieci: wariant awaryjny w `01-SCENARIUSZ.md` (patche `version-endpoint.patch` i `sabotaz.patch`); powiedz wprost, że to przygotowana zmiana.

---

## Slajd 13 · Umiejętności inżyniera w perspektywie 2–3 lat

### Na slajdzie

- 1 · Wymagania
- Rozpoznawanie problemu
- kto, w jakiej sytuacji i po co; rozpoznanie potrzeby
- 2 · Projekt
- Praca z danymi
- pochodzenie, jednostki, czas, braki, interpretacja
- 3 · Implementacja
- Delegowanie ograniczonych zadań
- zakres, kryterium akceptacji, warunek przerwania, architektura
- 4 · Weryfikacja
- Weryfikacja i wyjaśnianie wyników
- niezależny test, dowód, uzasadnienie decyzji
- 5 · Wdrożenie
- Współpraca i odpowiedzialność
- code review, zarządzanie zmianą, handover
- 6 · Utrzymanie
- Rozumienie istniejącego systemu
- kod, przepływ danych, ograniczenia, traceability
- W ciągu 2–3 lat AI może upowszechniać się wolniej albo szybciej (raczej szybciej). Te umiejętności przydadzą się w obu przypadkach, niezależnie od narzędzi.
- Na kursie zaczynamy od fazy utrzymania
- Przejmujemy istniejącą aplikację Mood Tracker i na niej ćwiczymy te umiejętności.

### Notatki prowadzącego (oryginał)

**Czas i cel**

48–51 min. Oddzielić umiejętności od narzędzi i pokazać, że są potrzebne w każdym scenariuszu tempa adopcji AI.

**Cel dydaktyczny**

Student potrafi nazwać sześć umiejętności przypisanych do faz SDLC i wie, które z nich ćwiczy na kursie.

**Objaśnienie**

Sześć umiejętności odpowiada fazom z poprzednich slajdów. Żadna nie jest przywiązana do konkretnego produktu czy nazwy narzędzia: agent może się zmienić, a formułowanie problemu, praca z danymi, delegowanie, weryfikacja, współpraca i rozumienie istniejącego systemu pozostają. Mówimy o umiejętnościach, nie o narzędziach.

**Scenariusze, nie prognoza**

Scenariusz wolniejszej adopcji: regulacje, koszty, problemy z jakością; AI pozostaje asystentem, a inżynier pisze i sprawdza więcej sam. Scenariusz szybszej adopcji: agenci wykonują większość implementacji; rośnie waga formułowania zadań, weryfikacji i odpowiedzialności za decyzję. W obu scenariuszach lista z tego slajdu jest potrzebna. Nie obiecujemy, który scenariusz się spełni, ani że te umiejętności gwarantują zatrudnienie.

**Związek z kursem**

Zaczynamy od fazy 6 (utrzymanie): przejmujemy istniejącą aplikację Mood Tracker, rozumiemy ją, a potem przechodzimy przez wymagania klienta, wybór wariantu, wykonanie, przekazanie i uzasadnienie. To mapa kursu na następnym slajdzie.

**Pytanie do grupy**

„Którą z tych umiejętności ćwiczycie już teraz, a której jeszcze nie?” Jedna, dwie odpowiedzi.

**Przejście**

„Tak wygląda plan kursu, który pozwoli te umiejętności przećwiczyć.”

**Źródła**

Synteza kursowa na podstawie slajdów o rynku IT i SDLC; bez nowych twierdzeń zewnętrznych.

### Zmiany na dziś

Zamiast pytania „którą ćwiczycie?” zacznij od: **„Których z tych sześciu umiejętności użyliśmy przed chwilą?”**
Oczekiwane: delegowanie (zakres, warunek przerwania), weryfikacja (diff, curl, sabotaż), rozumienie systemu (dwie wersje, brak testów API), rozpoznanie problemu (kto potrzebuje endpointu).

---

## Slajd 14 · Mapa kursu: pięć etapów pracy dla klienta

### Na slajdzie

- Etap
- Pytanie
- Rezultat
- Faza SDLC
- 1. Zrozumieć
- Jaki problem rozwiązujemy i dla kogo?
- opis kontekstu: fakty i założenia
- utrzymanie → wymagania
- 2. Wybrać
- Który wariant najlepiej odpowiada potrzebie i ograniczeniom klienta?
- porównane warianty i uzasadniony kierunek
- projekt
- 3. Wykonać
- Co sprawdzamy przed dalszą inwestycją czasu i zasobów?
- każda osoba: jeden ograniczony wkład inżynierski i recenzja wkładu partnera; dowody
- implementacja, weryfikacja
- 4. Przekazać
- Czy ktoś inny może przejąć naszą pracę?
- dokumentacja i przegląd
- wdrożenie, przekazanie
- 5. Uzasadnić
- Dlaczego ta decyzja?
- dossier: decyzja z dowodami i ograniczeniami
- cały cykl

### Notatki prowadzącego (oryginał)

**Czas i cel**

51–54 min. Pokazać strukturę semestru jako pięć etapów pracy inżyniera przypisanych do faz SDLC oraz wyjaśnić organizację projektu i rezultaty pracy studentów.

**Cel dydaktyczny**

Student wie, co będzie robić na kursie, co powstanie na końcu (dossier z uzasadnioną decyzją) i że liczba dodanych funkcji nie jest kryterium oceny.

**Objaśnienie etapów**

Zrozumieć: kto ma problem, w jakiej sytuacji, co wiemy, a co zakładamy; zaczynamy od fazy utrzymania, bo przejmujemy działający system, i dochodzimy do wymagań. Wybrać: porównanie wariantów i uzasadniony kierunek (projekt). Wykonać: każdy student prowadzi jeden ograniczony wkład inżynierski i recenzuje wkład partnera; zbieramy dowody (implementacja, weryfikacja). Przekazać: dokumentacja i przegląd, tak aby ktoś inny mógł przejąć pracę (wdrożenie, handover). Uzasadnić: decyzja z dowodami i ograniczeniami w dossier (cały cykl, traceability).

**Organizacja**

Pięć wykładów po 90 minut i pięć laboratoriów po 135 minut. 14 osób w 7 stałych parach. Wszystkie pary dostają tę samą wersję Mood Trackera i różne briefy klientów C01–C07. Każda para rozwija jedno dossier: wspólny zapis faktów, założeń, decyzji, dowodów i ograniczeń. Dopuszczalne rekomendacje: adaptacja aplikacji, zakup rozwiązania (build vs buy), uproszczenie procesu, odroczenie lub rezygnacja. Ocena nie zależy od liczby dodanych funkcji; czasem najlepszą decyzją jest niewprowadzanie zmiany.

**Role i doświadczenie z AI**

Pary są stałe; role wykonawcy i recenzenta rotują, aby każdy pisał i recenzował zmiany. Na L1 agenta uruchamia prowadzący; każdy student wykona własny cykl pracy z agentem na kolejnych laboratoriach, przed oceną tej kompetencji. Osoba z większym doświadczeniem nie „robi za parę”: w roli recenzenta pilnuje kryteriów akceptacji. Oceniamy opis zadania, sprawdzenie i uzasadnienie decyzji, nie szybkość pracy z narzędziem.

**Pytanie do grupy**

„Który etap wydaje się wam najbardziej nietypowy w porównaniu z dotychczasowymi projektami?” Zwykle: Przekazać i Uzasadnić.

Przejście do części 3

„Każdy z tych etapów zaczyna się od tego samego: od potrzeby klienta. I od tego zaczniemy trzecią część.”

**Źródła**

Dokumentacja kursu (sylabus, kryteria oceny w LMS). Bez twierdzeń zewnętrznych.

### Zmiany na dziś

Bez zmian. Jeśli brakuje czasu: jedno zdanie — „oceniamy decyzję i dowody, nie liczbę funkcji”.

---

## Slajd 15 · Potrzeba klienta jako początek pracy inżynierskiej

### Na slajdzie

- Część 3 · problem klienta i discovery · 54–90 min
- Co już wiemy
- Modele i narzędzia zmieniają się szybko, a cykl pracy zawsze zaczyna się od wymagań.
- Co robimy teraz
- Uczymy się ustalać, czego klient potrzebuje, zanim zaczniemy implementację.
- Dlaczego
- Błąd w rozpoznaniu potrzeby kosztuje najwięcej. AI przyspiesza wykonanie, ale nie rozpozna potrzeby za nas.
- W tej części
- Stakeholders
- Potrzeba a funkcja
- Intended purpose
- Rodzaje dowodów
- Przypadek poradni
- Ćwiczenie discovery
- Co musimy ustalić z klientem przed rozpoczęciem implementacji?

### Notatki prowadzącego (oryginał)

**Czas i cel**

54–55 min (1 min). Przejście do trzeciej części: od zmian w technologii i w procesie do konkretnej pracy inżyniera z klientem.

**Cel dydaktyczny**

Student rozumie, dlaczego kurs zaczyna od potrzeby klienta, a nie od implementacji, i wie, jakie tematy obejmie ta część.

**Do powiedzenia**

„Modele i narzędzia będą się zmieniać. Nie zmieni się to, że każda zmiana w systemie zaczyna się od pytania, czego klient potrzebuje. Klient w naszym kursie to podmiot, który podejmuje decyzję w scenariuszu: poradnia, badacz, kierowniczka. AI przyspiesza wykonanie; rozpoznania potrzeby nie zrobi za nas. Najdroższe błędy powstają właśnie tu.”

**Przejście**

„Zacznijmy od tego, kto w ogóle jest zainteresowany wynikiem: stakeholders.”

**Źródła**

Slajd przejściowy; bez twierdzeń zewnętrznych.

### Zmiany na dziś

Bez zmian. Możesz nawiązać do pokazu: „Agent dodał endpoint, którego nikt nie potrzebował — tak wygląda błąd w rozpoznaniu potrzeby w małej skali.”

---

## Slajd 16 · Stakeholders i konsekwencje decyzji

### Na slajdzie

- Wynik działania aplikacji
- podsumowanie samoopisów pacjenta
- Użytkownik
- pacjent wpisuje samoopis; potrzebuje prostego formularza
- Klient
- poradnia decyduje o prototypie; zależy jej na sprawnych wizytach
- Sponsor
- finansuje projekt; oczekuje mierzalnego efektu
- Operator
- koordynatorka obsługuje system i nietypowe sytuacje
- Ponosi konsekwencje błędu
- pacjent, jeśli wynik źle wpłynie na decyzję o leczeniu
- Jedna osoba może pełnić kilka ról. Każda rola ma inne potrzeby, uprawnienia i ryzyko.

### Notatki prowadzącego (oryginał)

**Czas i cel**

55–58 min. Wprowadzić pojęcie stakeholders (osób i podmiotów zainteresowanych wynikiem) i pokazać, że decyzja o produkcie ma różne konsekwencje dla różnych ról.

**Cel dydaktyczny**

Student potrafi wymienić role wokół jednego wyniku aplikacji (użytkownik, klient, sponsor, operator, osoba ponosząca konsekwencje błędu) i rozumie, że „klient” na kursie oznacza podmiot podejmujący decyzję w scenariuszu.

**Objaśnienie**

Stakeholder (interesariusz): każdy, kto wpływa na system lub odczuwa jego skutki. Użytkownik wpisuje samoopis (self-report, własna ocena stanu). Klient podejmuje decyzję: tu poradnia; w briefach C01–C07 klient jest nazwany w każdym scenariuszu. Sponsor finansuje i oczekuje efektu. Operator (tu koordynatorka) obsługuje system na co dzień, w tym wyjątki: brak wpisu, błąd, pytanie pacjenta. Osoba ponosząca konsekwencje błędu to często pacjent, który nie podejmował decyzji o systemie. Te role mogą się łączyć w jednej osobie, ale ich potrzeby, uprawnienia i ryzyko są różne.

**Pytanie do grupy**

„Kto w tym układzie najrzadziej jest pytany o zdanie, a najbardziej odczuwa skutki?” Oczekiwane: pacjent albo operator.

**Przejście**

„Kiedy wiemy, kto jest zainteresowany, możemy rozróżnić, czego ktoś potrzebuje, od tego, co proponuje.”

**Źródła**

Pojęcia ogólne z inżynierii wymagań; przypadek fikcyjny.

### Zmiany na dziś

**Zanim pokażesz slajd:** „Kto jest zainteresowany podsumowaniem samoopisów pacjenta?” Zbierz role na tablicy, potem pokaż slajd i porównaj. Pytanie z notatek bez zmian.

---

## Slajd 17 · Potrzeba, pomysł na funkcję, decyzja i niewiadoma

### Na slajdzie

- Potrzeba
- przygotowanie informacji do rozmowy z pacjentem
- Pomysł na funkcję
- dashboard z wykresami samoopisów
- Decyzja
- czy i w jaki sposób rozwijać istniejący system
- Niewiadoma
- kto korzysta z wyniku i w jakim celu?
- CZTERY ROZRÓŻNIENIA, DO KTÓRYCH BĘDZIEMY WRACAĆ
- Fakt / założenie
- Potrzeba / funkcja
- Twierdzenie / dowód
- Koszt / wartość

### Notatki prowadzącego (oryginał)

**Czas i cel**

58–61 min. Utrwalić cztery pojęcia (potrzeba, pomysł na funkcję, decyzja, niewiadoma) i cztery stałe rozróżnienia kursu.

**Cel dydaktyczny**

Student odróżnia potrzebę (problem, który ma zniknąć) od pomysłu funkcji (jedno z możliwych rozwiązań), nazywa decyzję, którą podejmuje klient, i wskazuje niewiadomą, która tę decyzję blokuje.

**Objaśnienie**

Potrzeba: przygotowanie informacji do rozmowy z pacjentem. Pomysł na funkcję: dashboard z wykresami; to propozycja rozwiązania, nie potrzeba. Decyzja: czy i jak rozwijać istniejący system; dopuszczalne odpowiedzi to także zakup gotowego rozwiązania, uproszczenie procesu, odroczenie lub rezygnacja. Niewiadoma: kto używa wyniku i do jakiej czynności; bez tej odpowiedzi nie da się ocenić, czy dashboard w ogóle odpowiada potrzebie.

Cztery rozróżnienia kursu: fakt / założenie (co potwierdzone, co przyjęte), potrzeba / funkcja, działanie / dowód (to, że coś działa, nie jest jeszcze dowodem, że działa poprawnie w warunkach docelowych), koszt / wartość. Wracają w dossier na każdym laboratorium.

**Pytanie do grupy**

„Klient mówi: potrzebujemy dashboardu. Jakie pytanie zadacie jako pierwsze?” Oczekiwane: do czego ma służyć i kto będzie go używał.

**Przejście**

„Odpowiedź na pytanie, kto i do czego używa wyniku, to intended purpose. I od niego zależy bardzo dużo.”

**Źródła**

Pojęcia kursowe; przypadek fikcyjny.

### Zmiany na dziś

**Quiz „Potrzeba czy funkcja?”** (kciuk w górę = potrzeba, w dół = funkcja). Klucz: `04-do-druku/quizy-slajdy-17-18.md`.

| Zdanie | Odpowiedź |
|--------|-----------|
| Dashboard z wykresami | funkcja |
| Mniej telefonów do koordynatorki | potrzeba |
| Powiadomienia push o 20:00 | funkcja |
| Wiedzieć, czy uczestnik w ogóle wypełnia wpisy | potrzeba |
| Eksport do CSV | funkcja |
| Porównywalne wyniki z dwóch ośrodków | potrzeba |

Przy każdej funkcji: „Jaka potrzeba może za nią stać?”

---

## Slajd 18 · Intended purpose i granice zastosowania

### Na slajdzie

- INTENDED PURPOSE OKREŚLA
- Dla kogo?
- W jakiej sytuacji?
- Do jakiej czynności?
- Z jakimi konsekwencjami?
- TEN SAM WYNIK, INNE ZASTOSOWANIE
- Zastosowanie A
- Lekarz czyta podsumowanie samoopisów przed rozmową i sam decyduje.
- Wymagania: poprawność, kompletność, czytelność. To, że decyzję podejmuje lekarz, nie wyklucza kwalifikacji oprogramowania jako wyrobu medycznego.
- Zastosowanie B
- Aplikacja wskazuje, czy pacjent może zwiększyć wysiłek.
- Potrzebne są dowody kliniczne; kwalifikacja jako wyrobu medycznego jest bardzo prawdopodobna.
- O kwalifikacji decydują przewidziane zastosowanie i funkcja oprogramowania, a nie etykieta „badawczy” ani to, kto podejmuje ostateczną decyzję.
- AI Act, art. 6 ust. 1: wysokie ryzyko, gdy AI jest wyrobem lub jego safety component, a wyrób wymaga oceny jednostki notyfikowanej; od 2.08.2028.
- Źródła: MDCG 2019-11 rev. 1 (2025); AI Act, rozp. (UE) 2024/1689, art. 6 i zał. I, zmienione rozp. (UE) 2026/1744 (Digital Omnibus).

### Notatki prowadzącego (oryginał)

**Czas i cel**

61–65 min. Wyjaśnić pojęcie intended purpose i pokazać, że ten sam wynik aplikacji przy innym użyciu oznacza inne wymagania, inne dowody i możliwą kwalifikację regulacyjną.

**Cel dydaktyczny**

Student potrafi opisać przeznaczenie produktu czterema pytaniami (dla kogo, w jakiej sytuacji, do jakiej czynności, z jakimi konsekwencjami) i rozumie, że o kwalifikacji jako wyrób medyczny decydują przeznaczenie i funkcja oprogramowania.

**Objaśnienie**

Intended purpose (przeznaczenie): deklaracja producenta, do czego produkt służy, dla kogo i w jakich warunkach. Zastosowanie A: podsumowanie czytane przez lekarza, który sam decyduje. Zastosowanie B: aplikacja wskazuje, czy pacjent może zwiększyć wysiłek; wynik wpływa na decyzję terapeutyczną. Ten sam wynik, inne użycie, inne wymagania i dowody.

Ważna korekta częstego uproszczenia: to, że lekarz sam podejmuje decyzję, nie wyklucza automatycznie kwalifikacji oprogramowania jako wyrobu medycznego. Według MDCG 2019-11 oprogramowanie jest wyrobem medycznym, jeśli jego przeznaczeniem jest m.in. wspieranie diagnozy, monitorowania, leczenia lub przewidywania przebiegu choroby przez przetwarzanie danych w celu medycznym; samo wyświetlanie, przechowywanie, archiwizacja lub proste wyszukiwanie zwykle nie kwalifikuje. Decyduje więc to, co oprogramowanie robi z danymi i po co, a nie etykieta „badawczy” czy „informacyjny”.

**AI Act (szczegóły prawne; nie czytać w całości)**

Rozporządzenie (UE) 2024/1689 (AI Act), zmienione rozporządzeniem (UE) 2026/1744 (Digital Omnibus on AI; przyjęte 8.07.2026, Dz.U. UE 24.07.2026, w mocy od 27.07.2026). Art. 6 ust. 1: system AI jest wysokiego ryzyka, gdy (a) jest produktem objętym prawodawstwem harmonizacyjnym z załącznika I (m.in. rozporządzenia MDR 2017/745 i IVDR 2017/746) albo safety component takiego produktu, oraz (b) produkt ten podlega ocenie zgodności przez stronę trzecią (jednostkę notyfikowaną). W praktyce dotyczy to wyrobów medycznych z udziałem jednostki notyfikowanej; nie formułujemy tego jako „każda klasa IIa i wyższa automatycznie”, bo kryterium jest udział strony trzeciej w ocenie zgodności i rola AI jako produktu lub safety component. Obowiązki dla systemów wysokiego ryzyka z załącznika I stosuje się od 2.08.2028 (po zmianie Omnibusem; wcześniej 2.08.2027). Obowiązki przejrzystości z art. 50 obowiązują od 2.08.2026. Przed zajęciami sprawdź aktualny stan w EUR-Lex i wytycznych Komisji.

**Pytanie do grupy**

„Czy aplikacja z użycia A może być wyrobem medycznym?” Odpowiedź: może, jeśli jej przeznaczeniem jest wspieranie decyzji medycznej przez przetwarzanie danych; trzeba zbadać funkcję i deklarowane przeznaczenie, a nie zakładać.

**Przejście**

„Skoro Zastosowanie B wymaga dowodów klinicznych, to jakie w ogóle są rodzaje dowodów?”

**Źródła**

MDCG 2019-11 rev. 1, Guidance on Qualification and Classification of Software in Regulation (EU) 2017/745 – MDR and Regulation (EU) 2017/746 – IVDR (Komisja Europejska, 2025). Rozporządzenie (UE) 2024/1689 (AI Act), art. 6 i załącznik I; rozporządzenie (UE) 2026/1744 (Digital Omnibus on AI), EUR-Lex.

### Zmiany na dziś

**Głosowanie „Wyrób medyczny czy nie?”** — ta sama aplikacja, cztery warianty (tak / nie / zależy):
1. Lista wpisów uczestnika.
2. Średni nastrój tygodniowo, czytany przez badacza.
3. Alert do psychologa po 3 dniach z nastrojem poniżej 3.
4. Aplikacja sugeruje uczestnikowi kontakt z lekarzem.

Rozstrzygnięcie jak w notatkach: decyduje przeznaczenie i funkcja. Wariant 3 zostaw sporny — to zamierzone. Kierunki odpowiedzi: `04-do-druku/quizy-slajdy-17-18.md`.

---

## Slajd 19 · Dowody techniczne, użytkowe i kliniczne

### Na slajdzie

- Techniczny
- Użytkowy
- Kliniczny
- Pytanie
- Czy system spełnia wymaganie?
- Czy docelowy użytkownik potrafi wykonać zadanie?
- Czy dowody potwierdzają przewidziane zastosowanie kliniczne?
- Przykład ilustracyjny: podsumowanie samoopisów z modelu AI
- Test na przygotowanych przypadkach: podsumowanie niczego nie pomija ani nie dodaje
- Fizjoterapeuta znajduje w podsumowaniu wpis o bólu w ustalonym czasie
- Badanie: wynik odzwierciedla stan pacjenta i pomaga w decyzji
- Czego nie pokazuje
- czy użytkownik poradzi sobie z systemem
- czy wynik jest klinicznie trafny
- czy wynik przenosi się na inne zastosowania i populacje
- Dowód jednego rodzaju nie zastępuje pozostałych. Dobry wynik ewaluacji modelu to wciąż tylko dowód techniczny.
- Schemat uproszczony. Przykłady w tabeli są ilustracyjne; żadne z tych badań nie zostało przeprowadzone. Źródło: IMDRF SaMD WG N41, Software as a Medical Device: Clinical Evaluation (2017).

### Notatki prowadzącego (oryginał)

**Czas i cel**

65–69 min. Rozróżnić trzy rodzaje dowodów i pokazać granice wnioskowania między nimi.

**Cel dydaktyczny**

Student odróżnia dowód techniczny (system działa zgodnie z wymaganiem), użytkowy (określony użytkownik wykonuje zadanie) i kliniczny (wynik wspiera zamierzone zastosowanie kliniczne) oraz wie, że dowód z jednego poziomu nie zastępuje innego.

**Objaśnienie**

Techniczny: testy, walidacja danych, porównanie z oczekiwanym wynikiem. Użytkowy: test użyteczności, obserwacja konkretnego użytkownika w konkretnej sytuacji. Kliniczny: dowody, że wynik wspiera zastosowanie kliniczne w docelowej populacji.

Przykłady w wierszu środkowym są wyłącznie ilustracyjne: pokazują, jak mógłby wyglądać dowód każdego rodzaju dla funkcji podsumowania samoopisów przez model AI. Nie wykonano ewaluacji na przypadkach testowych ani testu z fizjoterapeutą; powiedz to wprost, jeśli ktoś zapyta.

Odniesienie do IMDRF N41: ocena kliniczna oprogramowania jako wyrobu medycznego (SaMD) obejmuje ważny związek kliniczny (valid clinical association), walidację analityczną (poprawne przetworzenie danych wejściowych na wynik) i walidację kliniczną (zamierzony efekt w docelowej populacji). Nasz dowód techniczny jest bliski walidacji analitycznej; dowód kliniczny obejmuje związek kliniczny i walidację kliniczną. Dowód użytkowy to osobny wymiar (inżynieria użyteczności).

**Granice wnioskowania**

Wszystkie testy zielone nie mówią, że pacjent po zabiegu zrozumie formularz. Udany test z pięcioma studentami nie mówi nic o pacjentach 70+. Dobre wyniki kliniczne dla jednej populacji nie przenoszą się na inną ani na nowe zastosowanie. Dla funkcji z modelem AI: dobra ewaluacja wierności podsumowania to dowód techniczny, nie użytkowy ani kliniczny.

**Pytanie do grupy**

„Zespół mówi: aplikacja jest gotowa, bo testy przechodzą. Jakie pytanie zadacie?” Oczekiwane: kto i do czego jej użyje, i jakim dowodem to sprawdzono.

**Typowe nieporozumienie**

„Dowód kliniczny to sprawa lekarzy, nie inżyniera.” Inżynier decyduje o funkcjach, które zmieniają potrzebny poziom dowodu, więc musi wiedzieć, kiedy go zabraknie.

**Przejście**

„Zastosujmy to do jednego, fikcyjnego przypadku.”

**Źródła**

IMDRF SaMD Working Group, Software as a Medical Device (SaMD): Clinical Evaluation, IMDRF/SaMD WG/N41 FINAL:2017.

### Zmiany na dziś

**Nawiązanie do sabotażu:** „28 zielonych testów — jaki to rodzaj dowodu? Dla czego?” Oczekiwane: techniczny, i to tylko dla aplikacji mobilnej — nie dla serwera, nie użytkowy, nie kliniczny.

---

## Slajd 20 · Fikcyjny przypadek poradni rehabilitacyjnej

### Na slajdzie

- SYTUACJA FIKCYJNA
- Poradnia rehabilitacyjna chce aplikacji dla pacjentów po zabiegu.
- Dane: samoopisy pacjentów i dane z symulowanego czujnika.
- Sponsor proponuje codzienny wskaźnik gotowości do zwiększenia wysiłku.
- Zespół nie ma zatwierdzonej reguły klinicznej.
- Zadanie
- Ustalić zakres prototypu i informacje, których klient potrzebuje do decyzji.
- Poza zakresem
- Tworzenie algorytmu medycznego i reguły klinicznej.

### Notatki prowadzącego (oryginał)

**Czas i cel**

69–72 min. Wprowadzić wspólny, fikcyjny przypadek, na którym pokażemy rozwiązany fragment discovery i przeprowadzimy ćwiczenie.

**Cel dydaktyczny**

Student zna sytuację poradni, decyzję, którą musi podjąć klient, i granicę zakresu (bez algorytmu medycznego).

**Objaśnienie**

Przypadek jest fikcyjny i służy tylko wykładowi; nie jest jednym z briefów C01–C07, które pary dostają do projektu. Klient: poradnia (podejmuje decyzję o prototypie). Sponsor proponuje funkcję: codzienny wskaźnik gotowości do zwiększenia wysiłku. Zespół nie ma zatwierdzonej reguły klinicznej, więc taka funkcja wymagałaby dowodów klinicznych (slajd o rodzajach dowodów) i prawdopodobnie kwalifikacji jako wyrób medyczny (slajd o intended purpose). Zadanie inżyniera: ustalić zakres prototypu i informacje potrzebne do decyzji, nie zbudować algorytm.

**Pytanie do grupy**

„Co w tym opisie jest faktem, a co założeniem?” Krótko; pełne rozróżnienie na następnym slajdzie.

**Przejście**

„Zobaczmy jeden rozwiązany fragment discovery dla tego przypadku.”

**Źródła**

Przypadek fikcyjny, materiał kursowy.

### Zmiany na dziś

Bez zmian.

---

## Slajd 21 · Rozwiązany fragment discovery

### Na slajdzie

- DECYZJA
- Zakres prototypu: zestawienie samoopisów czy funkcja wpływająca na dobór wysiłku?
- FAKT
- Sponsor zgłosił pomysł na funkcję: codzienny wskaźnik gotowości.
- ZAŁOŻENIE
- Odbiorca będzie traktował wynik wyłącznie informacyjnie.
- PYTANIE
- Kto zobaczy wynik i jaką czynność wykona na jego podstawie?

### Notatki prowadzącego (oryginał)

**Czas i cel**

72–75 min. Pokazać na przykładzie, jak zapisujemy decyzję, fakt, założenie i pytanie, zanim studenci spróbują sami.

**Cel dydaktyczny**

Student widzi różnicę między faktem (sponsor zgłosił pomysł), założeniem (odbiorca potraktuje wynik informacyjnie) i pytaniem, które to założenie sprawdza. Rozumie, że pytanie ma wpływać na decyzję.

**Objaśnienie**

Decyzja klienta: czy prototyp ma tylko porządkować samoopisy, czy zawierać funkcję wpływającą na wybór wysiłku. Fakt: sponsor zgłosił pomysł na funkcję; to fakt o zgłoszeniu, nie o potrzebie. Założenie: odbiorca potraktuje wskaźnik wyłącznie informacyjnie; niesprawdzone, a od niego zależy poziom wymaganych dowodów i kwalifikacja regulacyjna. Pytanie: kto zobaczy wynik i jaką czynność wykona; odpowiedź przesuwa zakres w jedną albo drugą stronę. Pokaż, że każde pole ma swoje miejsce w dossier.

**Pytanie do grupy**

„Jeśli odpowiedź brzmi: fizjoterapeuta zmienia plan ćwiczeń na podstawie wskaźnika, co się zmienia w zakresie?” Oczekiwane: potrzebne dowody kliniczne; funkcja prawdopodobnie poza zakresem prototypu.

**Przejście**

„Teraz wasza próba, na zmienionym warunku.”

**Źródła**

Przypadek fikcyjny, materiał kursowy.

### Zmiany na dziś

Bez zmian.

---

## Slajd 22 · Ćwiczenie discovery

### Na slajdzie

- NOWY WARUNEK
- Sponsor akceptuje wyłącznie zestawienie samoopisów przed zaplanowaną rozmową.
- 4 min · samodzielnie
- Zapisz jedną decyzję, dwa założenia i trzy pytania.
- 4 min · w parze
- Wybierzcie pytanie o największym wpływie na decyzję.
- 4 min · omówienie
- Pary przedstawiają wybrane pytanie i uzasadnienie.
- Liczy się wpływ pytania na decyzję, nie liczba pytań. Trafnych odpowiedzi może być kilka.

### Notatki prowadzącego (oryginał)

**Cel i czas: 75–87 min (12 min)**

Pierwsza samodzielna próba discovery na zmienionym warunku. Studenci ćwiczą rozróżnienie decyzji, założeń i pytań oraz wybór pytania o największym wpływie.

**Przebieg**

0:00 – przeczytać nowy warunek na głos. Podkreślić: sponsor wycofał wskaźnik gotowości; zostaje zestawienie samoopisów przed zaplanowaną rozmową.

0:00–4:00 – praca samodzielna, w ciszy: jedna decyzja, dwa założenia, trzy pytania. Włączyć widoczny minutnik.

4:00–8:00 – praca w parach: porównać pytania, wybrać jedno o największym wpływie na decyzję i zapisać jedno zdanie uzasadnienia („jeśli odpowiedź brzmi X, zakres zmienia się na Y”).

8:00–12:00 – omówienie: 3–4 pary czytają wybrane pytanie; prowadzący dopisuje je na tablicy i grupuje.

**Klucz dla prowadzącego (nie pokazywać na slajdzie)**

Mimo zawężenia zakresu nadal trzeba ustalić: (1) odbiorcę – kto czyta uporządkowane samoopisy (fizjoterapeuta, lekarz, koordynatorka, pacjent) i do jakiej czynności przed rozmową; (2) zakres udostępniania – kto ma dostęp do samoopisów, w jakim okresie, czy pacjent widzi to samo co personel, czy dane trafiają do sponsora; (3) reakcję na brak danych – co pokazujemy, gdy pacjent nie wypełnił samoopisu lub wypełnił go częściowo, i kto reaguje.

Przykładowa decyzja: czy porządkowanie obejmuje tylko zestawienie chronologiczne, czy także oznaczanie zmian (np. wzrost bólu), które może zacząć sugerować interpretację.

Przykładowe założenia: odbiorca ma czas przeczytać podsumowanie przed rozmową; pacjenci wypełniają samoopisy regularnie; samoopisy są wystarczające bez danych z czujnika.

Przykładowe pytania o dużym wpływie: „Kto i ile minut przed rozmową czyta podsumowanie?”, „Kto może zobaczyć samoopisy poza osobą prowadzącą rozmowę?”, „Co ma się stać, gdy samoopisu brakuje?”

Akceptować różne trafne pytania, jeśli student potrafi wskazać, jak odpowiedź zmienia zakres lub potrzebne dowody. Słabsze pytania (np. „jaki kolor wykresu?”) przeformułować razem z grupą na pytanie o czynność odbiorcy.

**Typowe nieporozumienie**

„Skoro sponsor zawęził zakres, nie ma już niewiadomych.” Wyjaśnić: zawężenie usuwa jedną decyzję kliniczną, ale nie odpowiada na pytania o odbiorcę, dostęp i braki danych.

**Wariant dla par, które skończą wcześniej: porządkowanie przez model AI**

Dodaj warunek ustnie, nie na slajdzie: „Sponsor proponuje, żeby samoopisy porządkował model językowy.” Klucz podstawowy się nie zmienia: nadal trzeba ustalić odbiorcę, zakres udostępniania i reakcję na brak danych.

Dobre dodatkowe pytania: Co ma się stać, gdy podsumowanie pominie wpis o bólu? Kto sprawdzi podsumowanie przed rozmową i ile ma na to czasu? Czy dane mogą trafić do modelu w chmurze, czy tylko na urządzeniu? Na jakich przypadkach testowych ocenimy podsumowanie i co zrobimy po zmianie modelu?

Decyzja w tym wariancie: czy model porządkuje wpisy (grupuje, sortuje, cytuje dosłownie), czy je streszcza własnymi słowami. Pierwsze łatwiej sprawdzić; drugie wymaga ewaluacji wierności (slajd o rodzajach dowodów). Nie oceniaj tego wariantu; to rozszerzenie dla chętnych.

**Przejście**

„Zanotujcie swoje pytanie; ten sam sposób pracy, fakty, założenia i pytania do klienta, zastosujecie na laboratorium L1 do własnego briefu.”

**Źródła**

Ćwiczenie kursowe; przypadek fikcyjny.

### Zmiany na dziś

Przebieg jak w notatkach (4 + 4 + 4 min), plus **klient na żywo**: po odczytaniu pytań par odpowiadasz na najlepsze jako kierowniczka poradni, faktem, który zmienia zakres. Rola i ukryte fakty: `03-role/klient-poradnia.md`. Przykłady:
- „Kto czyta zestawienie i kiedy?” → „Fizjoterapeuta, ok. 2 minuty przed wizytą, na telefonie służbowym.”
- „Kto jeszcze widzi samoopisy?” → „Sponsor chce comiesięczny raport z danymi pacjentów.”
- „Co, gdy brakuje wpisu?” → „Koordynatorka dzwoni do pacjenta, ale ma na to godzinę tygodniowo.”

Po odpowiedzi: „Co ta odpowiedź zmieniła w zakresie prototypu?” Zasada roli: odpowiadasz tylko na to, o co zapytano.

---

## Slajd 23 · Exit ticket i przygotowanie do L1

### Na slajdzie

- EXIT TICKET · 2 MIN
- „Co muszę ustalić przed rozpoczęciem implementacji?”
- LABORATORIUM L1 · 135 MIN
- Przed L1: przeczytaj brief R0 swojej pary i otwórz dossier
- Przejęcie istniejącej aplikacji Mood Tracker
- Analiza kodu z agentem i samodzielne sprawdzenie jednego twierdzenia
- Jak aplikacja zapisuje i odczytuje samoopis
- Pytania do klienta, fakty, założenia i dwie niewiadome

### Notatki prowadzącego (oryginał)

**Czas i cel**

87–90 min. Zamknąć wykład jednym zdaniem od każdej osoby i zapowiedzieć L1.

**Cel dydaktyczny**

Student formułuje własnymi słowami, co trzeba ustalić przed implementacją, i wie, co przygotować na L1.

**Exit ticket (2 min)**

Każda osoba zapisuje jedno zdanie (kartka lub formularz w LMS), anonimowo. Przejrzyj odpowiedzi przed L1: pokazują, czy rozróżnienie potrzeby i funkcji oraz rola pytań discovery zostały zrozumiane. Nie oceniamy.

**Zapowiedź L1 (1 min)**

Przed L1 każda para otwiera własny brief R0 (dostępny w LMS przed zajęciami) i dossier. Na L1: przejęcie istniejącej aplikacji Mood Tracker (uruchomienie wspólnej wersji), demonstracja analizy kodu z agentem prowadzona przez prowadzącego i samodzielne sprawdzenie jednego twierdzenia, samodzielna analiza przepływu jednego samoopisu, pytania do klienta, fakty, założenia i dwie niewiadome. Na L1 nic nie implementujemy.

**Spójność z wykładem**

Przypomnij nić: AI zmienia produkty i badania (część 1), zmienia proces tworzenia oprogramowania (część 2), a praca inżyniera zaczyna się od potrzeby klienta (część 3). L1 zaczyna od zrozumienia istniejącego systemu i potrzeby klienta.

**Źródła**

Slajd organizacyjny; bez twierdzeń zewnętrznych.

### Zmiany na dziś

**Przed exit ticketem (75–85 min):**
1. Losowanie klientów: każda para losuje kartkę z tytułem briefu i imieniem klienta (`04-do-druku/losowanie-klientow.md`). Brief przeczytają przed L1.
2. Pokaż działającą aplikację: login `p01@study.example` / `demo1234`, dodaj wpis. „To przejmujecie. Nikt z poprzedniego zespołu nie odpowie na wasze pytania.”

**Zmiana w zapowiedzi L1:** studenci dostają kod jako archiwum ZIP (`mood-tracker.zip`) z README dostawcy, a nie klon repozytorium. Slajd 26 (L1) trzeba zaktualizować.
