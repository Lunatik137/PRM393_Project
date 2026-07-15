$ErrorActionPreference = "Stop"

Write-Host "Checking Flutter..."
flutter doctor

Write-Host "Installing dependencies..."
flutter pub get

Write-Host "Checking formatting..."
dart format --output=none --set-exit-if-changed .

Write-Host "Running analyzer..."
flutter analyze

Write-Host "Running tests..."
flutter test

Write-Host "Checking git status..."
git status --short

Write-Host "Initialization completed."