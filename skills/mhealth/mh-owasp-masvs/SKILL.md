---
name: mh-owasp-masvs
description: Review a mobile app against the OWASP MASVS control groups (storage, crypto, auth, network, platform, code, resilience, privacy) and decide which apply to this app's risk. Use when reviewing a Flutter/mobile app, before a pilot with real users, or when choosing what to verify with MASTG tests.
argument-hint: "[app area, e.g. token storage]"
---

# OWASP MASVS for mobile health apps (level 2)

MASVS says *what* a secure mobile app should achieve; MASTG describes *how* to test it.

## Control groups (MASVS v2)

| Group | Question for this app |
|-------|-----------------------|
| MASVS-STORAGE | Where does the app keep health data and tokens on the device? Encrypted? Backed up to the cloud? |
| MASVS-CRYPTO | Is crypto done with platform APIs and sound key handling, not home-made? |
| MASVS-AUTH | Are sessions handled by the server? What happens on logout and token expiry? |
| MASVS-NETWORK | Is all traffic TLS? Is cleartext allowed anywhere (e.g. debug config)? |
| MASVS-PLATFORM | Are IPC, deep links, WebViews and screenshots of sensitive screens controlled? |
| MASVS-CODE | Are dependencies current? Is input validated? Is the platform version supported? |
| MASVS-RESILIENCE | Does the threat model justify anti-tampering? (Often not for a research pilot — say why.) |
| MASVS-PRIVACY | Is data collection minimised, transparent, and under the user's control? |

## Steps

1. Decide which groups matter for this app and why (data sensitivity, who the users are,
   where devices are used). Not every group is equally relevant; justify the choice.
2. For each chosen group, find the code that implements it (file:line) and check it.
3. Where a check needs a device (backups, screenshots, traffic), describe the test and run it
   on an emulator with synthetic data, or mark it as not executed.

## Output

| Group | Relevant? (why) | What the app does (file:line) | Result | Test executed? |
|-------|-----------------|-------------------------------|--------|----------------|

## Done when

- Each group is either checked with evidence or explicitly scoped out with a reason.
- Results distinguish "checked in code" from "verified on a device".

Source: OWASP MASVS v2 and MASTG (mas.owasp.org). Check for the current version before use.
