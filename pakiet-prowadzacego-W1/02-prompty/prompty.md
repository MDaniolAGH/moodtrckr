# Prompty do pokazów (GitHub Copilot, Chat → tryb Agent)

Każdy prompt w **nowej sesji czatu** („+”), chyba że zaznaczono inaczej.
Po każdej próbie: reset kopii demo (`01-SCENARIUSZ.md`, „Reset po pokazie”).

---

## P1 · Slajd 12 — zlecenie dla agenta (endpoint /version)

```
Pracuj w katalogu mood-tracker-api. Dodaj endpoint GET /version w aplikacji FastAPI,
który zwraca JSON z dwoma polami: service (nazwa serwisu) i version (wersja aplikacji,
odczytana z istniejącego miejsca w kodzie, jeśli takie jest). Endpoint nie odczytuje danych
uczestników, nie wymaga uwierzytelnienia i nie dotyka bazy danych. Zakres: wyłącznie nowy
endpoint i jedno zdanie w README. Bez nowych zależności. Nie zmieniaj modeli danych,
schematów, uwierzytelniania ani istniejących endpointów. Zanim zmienisz pliki, przedstaw plan:
które pliki zmienisz i dlaczego. Jeśli potrzebna jest zmiana poza zakresem, zatrzymaj się i zapytaj.
```

Kontynuacja w tej samej sesji, po omówieniu planu:

```
Wykonaj plan.
```

Wynik próby (Copilot, bez kontekstu, 30.10.2026): nie zapytał o wersję; zmienił
`app/main.py` (endpoint z `app.version`) i `mood-tracker-api/README.md` (jedno zdanie);
nie zapytał, które z trzech README. Zatwierdzony jako commit z tagiem `exp1-copilot-no-context`
w `~/dev/demo-agentic`.

## P2 · Porównanie kontekstów — zadanie krótkie

Ten sam prompt w czterech sesjach, przed każdą inny plik `.github/copilot-instructions.md`
(`05-demo-agentic/konteksty/`: brak → 1-persona → 2-ogolniki → 3-profesjonalny).

```
Dodaj do serwera FastAPI endpoint GET /version, który zwraca nazwę serwisu i wersję aplikacji.
```

Tabela na tablicy po każdym wariancie: zapytał? plan? test? curl? zmiany poza zakresem?

## P3 · Skill — opis przepływu danych

Bez kontekstu; najpierw bez skilli, potem po skopiowaniu `github/skills/` do `.github/skills/`.

```
Jak aplikacja zapisuje samoopis, gdy nie ma internetu?
```

Wywołanie wprost (gdy Copilot sam nie załaduje skilla):

```
/opisz-przeplyw zapis samoopisu bez internetu
```

## P4 · Skill — zmiana w API

Po skopiowaniu skilli; ten sam tekst co P2. Szukaj: pytania przed pracą, test przed zmianą,
wynik curl, sekcja „nie sprawdzono”.

## P5 · Agent eksplorator — ograniczenie uprawnień

Agent `eksplorator` wybrany z listy agentów w polu czatu.

```
Popraw literówkę w README.
```

Oczekiwane: nie może zmienić pliku (ma tylko `read` i `search`).

## P6 · Agent recenzent — niezależna recenzja

Najpierw zmiana z sabotażem (`01-SCENARIUSZ.md`, 2.7 lub wariant awaryjny). Nowa sesja,
agent `recenzent`.

```
Sprawdź zmianę względem zlecenia: GET /version zwraca JSON z polami service i version;
istniejące testy przechodzą.
```

Szukaj: czy zauważy, że żaden test nie wykonuje nowego kodu; czy wywoła endpoint.

## P7 · Porównanie modeli (opcjonalnie, OpenRouter przez Manage Models)

Kontekst `3-profesjonalny.md`, prompt P2, kolejno różne modele z listy modeli w czacie.
Porównaj z P2: większą różnicę robi model czy kontekst?

## P8 · Pytanie do agenta o kod — tryb odczytu (zapowiedź L1, slajd 27)

```
Pracuj w trybie odczytu w repozytorium moodtracker-handover. Ustal, jak aplikacja tworzy
MoodEntry z odpowiedzi API i gdzie wywołuje fromJson. Wskaż pliki oraz funkcje. Oddziel fakty
widoczne w kodzie od hipotez. Nie zmieniaj plików. Nazwij granice tego sprawdzenia.
```
