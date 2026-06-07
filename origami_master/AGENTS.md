# AGENTS.md - Origami Master Flutter Project

## Project Context

Origami Master is a Flutter mobile application focused on:
1. Step-by-step origami learning.
2. Fold Detail screen with community gallery for the selected fold type.
3. User gallery of completed creations.
4. Private share links for user creations.
5. Achievement list.

Current phase:
- UI implementation only.
- Use mock data and local assets.
- Backend will be added in the future.
- Do not implement real API, authentication backend, or cloud storage yet.

## Tech Stack

- Flutter
- Dart
- Material 3 or custom theme
- Local mock data
- Local image assets
- Future backend via repository layer

## Architecture Rules

Use feature-first structure:

lib/
├── app/
├── core/
├── data/
└── features/

Each feature should contain:
- screens/
- widgets/
- models/
- providers/ or controllers/

## Important Rules

1. Do not change app scope without permission.
2. Do not add new screens unless listed in feature_list.json.
3. Do not remove existing screens unless the task says so.
4. Do not hard-code large mock data directly inside widgets.
5. Use reusable widgets for cards, buttons, bottom navigation, badges, and grids.
6. UI must match the Origami Master design system:
    - warm cream background
    - brown/gold accents
    - rounded cards
    - soft shadows
    - elegant Japanese-inspired minimalism
7. Backend must be prepared through repositories, but not implemented yet.
8. Every task must pass:
    - flutter pub get
    - dart format
    - flutter analyze
    - flutter test

## Definition of Done

A task is done only when:
- The requested screen/feature is implemented.
- UI is responsive.
- Mock data is connected.
- Navigation works.
- No analyzer errors.
- Tests pass or existing tests are not broken.
- progress.md is updated.