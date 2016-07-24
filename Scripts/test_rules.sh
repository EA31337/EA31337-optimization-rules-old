#!/usr/bin/env bash
# Script to test rules for any errors.
set -e
[ "$TRACE" ] && set -x
ROOT="$(git rev-parse --show-toplevel)"
SETFILE="$ROOT/Sets/Lite/EURUSD/default/2000USD/10-spread/5-digits/2014/EA31337-Lite.set.test"
TESTER_INI="$ROOT/_VM/conf/mt4-tester.ini.test"
EA_INI="$ROOT/_VM/conf/ea.ini.test"
cp -f "${SETFILE%.*}" "${SETFILE}"
cp -f "${TESTER_INI%.*}" "${TESTER_INI}"
cp -f "${EA_INI%.*}" "${EA_INI}"

cd "$ROOT"
. ./_VM/scripts/.funcs.inc.sh
. ./_VM/scripts/.vars.inc.sh
. ./Common/.init.rules.inc

find "$ROOT" -type f -name "*$1*.rule" -print0 | sort -z | while IFS= read -r -d '' rule_file; do
  echo "Testing $(basename ${rule_file} .rule)..."
  . "$rule_file"
done
find "$ROOT" -type f -name "*.test" -delete
echo $0 OK
