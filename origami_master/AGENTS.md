# AGENTS.md

## Project

Origami Master is a Flutter mobile application for learning origami.

## Required Reading Order

Before making changes:

1. Read AGENTS.md
2. Run init.ps1
3. Read progress.md
4. Read feature_list.json
5. Read TASK.md
6. Read the relevant files in docs/
7. Inspect existing related code
8. Check recent git history

## Scope Rule

Work on exactly one unfinished feature per session.

Do not modify unrelated screens.
Do not mark other features complete.
Do not rewrite the feature list to hide unfinished work.

## Flutter Rules

- Use Dart and Flutter Material 3.
- Use SafeArea.
- Prefer Row, Column, ListView, GridView, Expanded and LayoutBuilder.
- Avoid full-screen Stack and absolute positioning.
- Do not hardcode device width or height.
- Long screens must be scrollable.
- Shared UI must be extracted into reusable widgets.

## Design Rules

- Follow docs/DESIGN_SYSTEM.md.
- Use centralized colors, spacing, typography and radius.
- Do not introduce screen-specific colors directly.
- Do not add components not listed in the screen specification.

## Product Rules

- No Daily Challenge.
- No Achievements.
- New creations are Private by default.
- Community Gallery only shows:
   - isPublic == true
   - origamiId matches the selected model
- Shared Creation is read-only.
- Disabled or deleted links show Link Expired / Not Found.

## Verification

Before claiming completion, run:

```bash
dart format .
flutter analyze
flutter test
```

A feature is not complete unless all required checks pass.

## Session End

Before stopping:

Update progress.md
Update only the current item in feature_list.json
Record validation evidence
Record remaining issues
Leave the repository in a clean resumable state