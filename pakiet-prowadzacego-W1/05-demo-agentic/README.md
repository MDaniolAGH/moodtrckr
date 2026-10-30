# Demonstracje: kontekst, skill, agent, sabotaż (GitHub Copilot w VS Code)

Materiał prowadzącego. Pokazuje wpływ każdego elementu na pracę agenta na Mood Trackerze
(commit bazowy studentów `58747273`). Nie dawać studentom przed tym, jak napiszą własny kontekst.

## Gdzie Copilot szuka plików

| Element | Miejsce w repozytorium | W tym folderze |
|---------|------------------------|----------------|
| Kontekst (zawsze dołączany) | `.github/copilot-instructions.md` | `konteksty/*.md` |
| Skille | `.github/skills/<nazwa>/SKILL.md` | `github/skills/` |
| Agenci | `.github/agents/<nazwa>.agent.md` | `github/agents/` |

Copilot czyta też `AGENTS.md` w katalogu głównym. W repo demo nie może go być, inaczej
wynik porównania kontekstów się zafałszuje.

Wszystko w **Chat → tryb Agent**. Po każdej odpowiedzi rozwiń **References** pod odpowiedzią —
widać tam, które instrukcje i skille Copilot faktycznie dołączył. To dobry dowód dla sali.

## Przygotowanie (poza SynologyDrive)

```bash
git clone "$HOME/SynologyDrive/AGH/Dydaktyka/Aplikacje Mobilne w Chirurgii/2026/moodtracker-handover" ~/dev/demo-agentic
cd ~/dev/demo-agentic && git checkout 58747273 && git switch -c demo/version-endpoint
cd mood-tracker-api && python3 -m venv venv && venv/bin/pip install -r requirements.txt
mkdir -p ~/dev/demo-agentic/.github
```

Otwórz `~/dev/demo-agentic` w VS Code.

Zmiana wariantu kontekstu, zawsze w **nowej sesji czatu** (przycisk „+” w Chat):

```bash
M="$HOME/SynologyDrive/AGH/Dydaktyka/Aplikacje Mobilne w Chirurgii/2026/pakiet-prowadzacego-W1/05-demo-agentic"
cp "$M/konteksty/3-profesjonalny.md" ~/dev/demo-agentic/.github/copilot-instructions.md  # lub 1-persona, 2-ogolniki
rm ~/dev/demo-agentic/.github/copilot-instructions.md                                   # wariant 0: brak kontekstu
```

Odpowiedzi agenta są niedeterministyczne. Każdą demonstrację przećwicz raz przed zajęciami
i zapisz zrzut ekranu jako wariant awaryjny. Poniżej opisano, **czego szukać**, nie gwarantowany wynik.

---

## Demonstracja 1 — kontekst (to samo zadanie, cztery konteksty)

Zadanie (identyczne w każdej sesji):

> Dodaj do serwera FastAPI endpoint GET /version, który zwraca nazwę serwisu i wersję aplikacji.

| Wariant | Plik | Czego się spodziewać |
|---------|------|----------------------|
| 0 | brak | Agent od razu pisze kod; wartość wersji zgaduje lub wpisuje na sztywno. |
| 1 | `1-persona.md` | Brzmi pewniej, robi to samo. Persona nie daje agentowi żadnej informacji. |
| 2 | `2-ogolniki.md` | Może dopisać test lub dokumentację „bo dobre praktyki”, ale nie wie, gdzie ani jak go uruchomić. |
| 3 | `3-profesjonalny.md` | Powinien zapytać, której wersji dotyczy zlecenie, przedstawić plan, użyć istniejącego `app.version`, zauważyć brak testów serwera i zapytać o zależność `pytest`. |

Po każdej próbie: **Keep / Undo** w panelu zmian (albo `git checkout .`), żeby kolejny wariant
startował z tego samego kodu.

Studenci przed każdym wariantem przewidują wynik. Po wszystkich czterech: tabela na tablicy
(pytał? plan? test? sprawdził curl? zmiany poza zakresem?).

Wniosek do nazwania: **kontekst działa przez informacje, których agent nie wyczyta sam**
(polecenia, ograniczenia, znane pułapki), a nie przez przymiotniki.

## Demonstracja 2 — skill (format i procedura)

Wariant kontekstu 0 (żeby było widać sam wpływ skilla).

a) Najpierw bez skilli, potem po skopiowaniu `opisz-przeplyw`:

```bash
cp -R "$M/github/skills" ~/dev/demo-agentic/.github/
```

> Jak aplikacja zapisuje samoopis, gdy nie ma internetu?

Szukaj: bez skilla — opis prozą, część twierdzeń bez plików. Ze skillem — tabela kroków
z plikiem i linią, rozgałęzienia (błąd sieci), sekcja „granice sprawdzenia”. W References
widać, że skill został załadowany. Skill można też wywołać wprost: `/opisz-przeplyw`.

b) Ze skillem `zmiana-w-api` to samo zadanie co w demonstracji 1.

Szukaj: pytania przed pracą, test przed zmianą, wynik curl, raport z sekcją „nie sprawdzono”.

Wniosek: **kontekst mówi, co jest prawdą o projekcie; skill mówi, jak wykonać powtarzalną
procedurę**. Copilot ładuje skill, gdy jego `description` pasuje do zadania — ale nie ma
gwarancji, że zrobi to za każdym razem. Jeśli nie załaduje, to też jest lekcja.

## Demonstracja 3 — agenci (uprawnienia i niezależność)

```bash
cp -R "$M/github/agents" ~/dev/demo-agentic/.github/
```

Agenta wybierasz z listy agentów w polu czatu (tam, gdzie „Agent”).

a) **Uprawnienia.** Wybierz `eksplorator` i poproś: „Popraw literówkę w README.”
Eksplorator ma tylko narzędzia `read` i `search` — nie może zmienić pliku. Ograniczenie wynika
z narzędzi w pliku agenta, nie z prośby w prompcie. Pokaż listę narzędzi (ikona narzędzi w czacie).

b) **Niezależna recenzja.** Zastosuj zmianę z sabotażem (niżej). Nowa sesja, agent `recenzent`:

> Sprawdź zmianę względem zlecenia: GET /version zwraca JSON z polami service i version;
> istniejące testy przechodzą.

Recenzent nie widział rozmowy, w której powstała zmiana. Szukaj: czy zauważy, że żaden test
nie wykonuje nowego kodu, i czy wywoła endpoint. Ma narzędzie `execute`, więc VS Code poprosi
o zgodę na uruchomienie poleceń — to też warto pokazać.

Wniosek: **osobny agent = osobne uprawnienia i świeże spojrzenie**. Recenzent, który nie widział
tworzenia zmiany, nie „wie”, że jest dobra.

---

## Sabotaż — sprawdzony 30.10.2026

Pliki w `sabotaz/`: `version-endpoint.patch` (poprawny endpoint), `sabotaz.patch`
(literówka `versoin`), `test_version.py` (test serwera). Oba patche nakładają się czysto
na `58747273`. Sabotaż nie zależy od narzędzia AI.

```bash
cd ~/dev/demo-agentic
git apply "$M/sabotaz/version-endpoint.patch"    # poprawny endpoint
git apply "$M/sabotaz/sabotaz.patch"             # sabotaż: pole "versoin"
(cd mood_tracker && flutter test)                # nadal 28/28

# test serwera (pytest i httpx tylko w venv demo)
cd mood-tracker-api && venv/bin/pip install pytest httpx
mkdir -p tests && cp "$M/sabotaz/test_version.py" tests/
venv/bin/python -m pytest -q tests               # FAIL po sabotażu
```

Wyniki (macOS, Flutter 3.35, Python 3.12):

| Sprawdzenie | Kod poprawny | Kod po sabotażu |
|-------------|--------------|-----------------|
| `flutter test` | 28/28 pass | **28/28 pass** |
| `curl /version` | `{"service":"Mood Tracker API","version":"1.0.0"}` | `{"service":"Mood Tracker API","versoin":"1.0.0"}` |
| `pytest` z `test_version.py` | 2 passed | **FAIL**: `Left contains 1 more item: {'versoin': '1.0.0'}` |

### Na jakiej zasadzie działa

1. **Testy sprawdzają tylko kod, który wykonują.** W `mood-tracker-api/` nie ma żadnego testu.
   28 testów Fluttera dotyczy aplikacji mobilnej — nowy kod serwera nie jest wykonywany ani razu.
2. **Testy Fluttera nie rozmawiają z serwerem.** Używają mocków (`MockAuthService`,
   `MockHttpClient` w `mood_tracker/test/`), więc nawet umowa klient–serwer nie jest sprawdzana.
3. **Kryterium „istniejące testy przechodzą” jest prawdziwe i puste.** Mówi, że nic nie zepsuliśmy
   w tym, co jest testowane — nic o nowym zachowaniu.
4. **Dowód daje sprawdzenie, które wykonuje zmieniony kod i porównuje dokładny wynik**:
   ręczne wywołanie (curl) albo test serwera, który zna nazwy pól.

Pytanie do sali po pokazie: „Jakie kryterium akceptacji napisalibyście teraz?”
Oczekiwane: test, który wywołuje GET /version i sprawdza nazwy pól oraz wartość wersji.

`test_version.py` wymaga `pytest` i `httpx`, których nie ma w `requirements.txt`. To dobry
moment na pytanie: czy dodanie zależności testowej mieści się w zakresie „bez nowych zależności”?

## Źródła (dokumentacja VS Code, sprawdzone 30.10.2026)

- Custom instructions: https://code.visualstudio.com/docs/agent-customization/custom-instructions
- Agent Skills: https://code.visualstudio.com/docs/agent-customization/agent-skills
- Custom agents: https://code.visualstudio.com/docs/agent-customization/custom-agents
