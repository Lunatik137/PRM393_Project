#!/usr/bin/env bash
set -e

echo "== Format =="
dart format .

echo "== Analyze =="
flutter analyze

echo "== Test =="
flutter test

echo "== Build smoke test =="
flutter build apk --debug

echo "All verification steps passed."