$ErrorActionPreference = "Stop"

Write-Host "Formatting..."
dart format .

Write-Host "Analyzing..."
flutter analyze

Write-Host "Testing..."
flutter test

Write-Host "Verification passed."