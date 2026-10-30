# Skille mHealth — zgodność, bezpieczeństwo, prywatność (stopniowane)

Osiem małych skilli w czterech poziomach. Każdy poziom zakłada poprzedni. Instrukcje po angielsku
(dla agenta); każdy skill kończy się kryterium „Done when” i wymaga dowodów (plik:linia,
żądanie i odpowiedź, wynik testu). Skille **nie są poradą prawną ani regulacyjną** — uczą
zadawać właściwe pytania i zbierać dowody.

| Poziom | Skill | Zasada | Typowy moment w kursie |
|--------|-------|--------|------------------------|
| 1 · Świadomość danych | `mh-data-inventory` | Nie ochronisz danych, których nie spisałeś | Etap 1: Zrozumieć |
| 1 | `mh-secrets-and-config` | Domyślne ustawienie deweloperskie to ryzyko produkcyjne | Etap 1: Zrozumieć |
| 2 · Bezpieczeństwo aplikacji | `mh-owasp-api` | Sprawdzaj API żądaniami, nie intencjami (OWASP API Top 10 2023) | Etap 3: Wykonać |
| 2 | `mh-owasp-masvs` | Wybierz kontrole MASVS adekwatne do ryzyka i uzasadnij wybór | Etap 3: Wykonać |
| 3 · Prywatność i przeznaczenie | `mh-gdpr-health-data` | Inżynier nie wybiera podstawy prawnej, ale buduje to, co umożliwia zgodność | Etap 2: Wybrać |
| 3 | `mh-intended-purpose` | Ta sama funkcja może być dziennikiem albo wyrobem medycznym | Etap 2: Wybrać |
| 4 · Cykl życia wyrobu | `mh-iec62304-traceability` | Wymaganie → projekt → kod → test → kontrola ryzyka | Etap 4: Przekazać |
| 4 | `mh-iso14971-risk` | Najpierw „co może pójść źle dla człowieka”, potem „w kodzie” | Etap 2–3 |

## Jak wprowadzać

- Jeden poziom na laboratorium; skill dajemy **po** tym, jak para zetknie się z problemem
  (np. `mh-secrets-and-config` po odkryciu domyślnego klucza w konfiguracji).
- Skille poziomu 3–4 korzystają z wyników niższych poziomów (np. analiza ryzyka używa
  przeznaczenia i inwentarza danych).
- Każdy wynik skilla trafia do dossier z dowodami.

## Instalacja (GitHub Copilot)

```bash
cp -R moodtrckr/skills/mhealth/mh-* <repo>/.github/skills/
```

Wywołanie: `/mh-owasp-api /moods`, `/mh-data-inventory wpisy nastroju` itd.

## Źródła (sprawdzić aktualne wersje przed zajęciami)

- OWASP API Security Top 10 — 2023 (owasp.org)
- OWASP MASVS v2, MASTG (mas.owasp.org)
- Rozporządzenie (UE) 2016/679 (RODO): art. 5, 6, 9, 25, 35
- Rozporządzenie (UE) 2017/745 (MDR), zał. VIII reguła 11; MDCG 2019-11 rev. 1
- IEC 62304:2006 + A1:2015
- ISO 14971:2019; ISO/TR 24971:2020
