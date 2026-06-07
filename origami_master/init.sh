#!/usr/bin/env bash
set -e

echo "== Origami Master init =="

flutter --version
flutter pub get

echo "== Analyze project =="
flutter analyze || true

echo "== Current task =="
cat TASK.md || true

echo "== Feature list =="
cat feature_list.json || true

echo "== Recent progress =="
cat progress.md || true