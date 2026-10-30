#!/usr/bin/env bash
# Automatic rehearsal of the sabotage demo (macOS / Linux).
#
# Builds a throwaway copy of Mood Tracker at the student base commit, adds GET /version,
# checks it, applies the sabotage ("version" -> "versoin") and verifies the three outcomes
# the lecture relies on:
#   1. flutter test still passes (28/28)  -> existing tests do not see the bug
#   2. curl shows the wrong field          -> a manual check does
#   3. pytest test_version.py fails        -> a server test does
#
# Usage:  ./test_sabotazu.sh [path/to/moodtracker-demo.bundle]
#         KEEP=1 ./test_sabotazu.sh        # keep the temporary copy for inspection
# Exit code 0 = the demo will behave as planned.

set -uo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
BUNDLE="${1:-$HERE/../../06-kod-demo/moodtracker-demo.bundle}"
BASE=58747273
WORK="$(mktemp -d)"
SERVER_PID=""

cleanup() {
  [[ -n "$SERVER_PID" ]] && kill "$SERVER_PID" 2>/dev/null
  if [[ "${KEEP:-0}" == "1" ]]; then echo "Copy kept in: $WORK"; else rm -rf "$WORK"; fi
}
trap cleanup EXIT

results=()
check() {  # check <description> <expected> <actual>
  local status="FAIL"; [[ "$2" == "$3" ]] && status="PASS"
  results+=("$status|$1|expected: $2|got: $3")
}

for tool in git python3 flutter curl; do
  command -v "$tool" >/dev/null || { echo "Missing tool: $tool"; exit 2; }
done
[[ -f "$BUNDLE" ]] || { echo "Bundle not found: $BUNDLE"; exit 2; }

echo "== Preparing copy at $BASE in $WORK"
git clone -q "$BUNDLE" "$WORK/mt" && cd "$WORK/mt" && git checkout -q "$BASE" || exit 2
git -c user.name=demo -c user.email=demo@example.com switch -q -c demo/sabotage-test

cd mood-tracker-api
python3 -m venv venv && venv/bin/pip install -q -r requirements.txt pytest httpx 2>&1 | grep -v -i notice
PORT="$(python3 -c 'import socket; s=socket.socket(); s.bind(("",0)); print(s.getsockname()[1])')"
cd ..
RELOAD_MISSED=0

start_server() {
  [[ -n "$SERVER_PID" ]] && kill "$SERVER_PID" 2>/dev/null && wait "$SERVER_PID" 2>/dev/null
  (cd mood-tracker-api && DATABASE_URL="sqlite:///$WORK/demo.db" venv/bin/uvicorn app.main:app \
    --reload --port "$PORT" >>"$WORK/uvicorn.log" 2>&1) &
  SERVER_PID=$!
  for _ in $(seq 60); do curl -s "localhost:$PORT/" >/dev/null && return 0; sleep 0.5; done
  return 1
}

wait_for() {  # wait_for <substring>: wait for --reload; if it does not happen in 30 s, restart
  for _ in $(seq 60); do curl -s "localhost:$PORT/version" | grep -q "$1" && return 0; sleep 0.5; done
  echo "   (auto-reload did not pick up the change in 30 s; restarting the server)"
  RELOAD_MISSED=$((RELOAD_MISSED + 1))
  start_server
  curl -s "localhost:$PORT/version" | grep -q "$1"
}

start_server || { echo "API did not start"; exit 2; }

echo "== Step 1: correct endpoint"
git apply "$HERE/version-endpoint.patch" || { echo "version-endpoint.patch does not apply"; exit 2; }
git -c user.name=demo -c user.email=demo@example.com commit -qam "Add GET /version"
wait_for '"version"'
check "GET /version (correct code)" '{"service":"Mood Tracker API","version":"1.0.0"}' "$(curl -s "localhost:$PORT/version")"
check "GET / still ok" "ok" "$(curl -s "localhost:$PORT/" | python3 -c 'import sys,json; print(json.load(sys.stdin)["status"])')"

echo "== Step 2: sabotage"
git apply "$HERE/sabotaz.patch" || { echo "sabotaz.patch does not apply"; exit 2; }
# The sabotage keeps main.py the same size. If it lands in the same second as the previous write,
# Python's bytecode cache (validated by source size + mtime in whole seconds) and the reloader keep
# running the old code. A fresh mtime one second later avoids that.
sleep 1.1 && touch mood-tracker-api/app/main.py
check "git diff shows exactly -version/+versoin" "2" "$(git diff | grep -c '^[-+] ')"
wait_for '"versoin"'
check "GET /version (sabotaged)" '{"service":"Mood Tracker API","versoin":"1.0.0"}' "$(curl -s "localhost:$PORT/version")"

echo "== flutter test (may take a minute on first run)"
FLUTTER_OUT="$(cd mood_tracker && flutter pub get >/dev/null 2>&1 && flutter test 2>&1)"
check "flutter test after sabotage" "+28: All tests passed!" \
  "$(grep -oE '\+[0-9]+( -[0-9]+)?: (All tests passed!|Some tests failed.)' <<<"$FLUTTER_OUT" | tail -1)"

echo "== pytest with test_version.py"
mkdir -p mood-tracker-api/tests && cp "$HERE/test_version.py" mood-tracker-api/tests/
PYTEST_OUT="$(cd mood-tracker-api && DATABASE_URL="sqlite:///$WORK/demo.db" venv/bin/python -m pytest -q tests 2>&1)"
check "pytest after sabotage" "1 failed, 1 passed" "$(grep -oE '[0-9]+ failed, [0-9]+ passed|[0-9]+ passed|[0-9]+ errors?' <<<"$PYTEST_OUT" | head -1)"
echo "$PYTEST_OUT" > "$WORK/pytest.log"
check "pytest names the wrong field" "yes" "$(grep -q "{'versoin': '1.0.0'}" <<<"$PYTEST_OUT" && echo yes || echo no)"

echo
printf '%-5s | %-42s | %s\n' "" "Check" "Detail"
fails=0
for r in "${results[@]}"; do
  IFS='|' read -r st name exp got <<<"$r"
  printf '%-5s | %-42s | %s ; %s\n' "$st" "$name" "$exp" "$got"
  [[ "$st" == "FAIL" ]] && fails=$((fails + 1))
done
echo
[[ $RELOAD_MISSED -gt 0 ]] && echo "Note: auto-reload missed a change $RELOAD_MISSED time(s). In class, if /version shows old output, restart uvicorn (Ctrl+C, start again)."
if [[ $fails -eq 0 ]]; then
  echo "RESULT: the sabotage demo behaves as planned (${#results[@]}/${#results[@]} checks)."
else
  echo "RESULT: $fails check(s) failed — do not rely on the live demo; see uvicorn.log and pytest.log (run with KEEP=1)."
fi
exit "$fails"
