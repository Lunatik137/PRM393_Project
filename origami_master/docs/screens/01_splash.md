# Splash Screen

## Purpose
The Splash Screen is the application entry point. It initializes local data, image assets, and application resources, then checks whether a valid saved login session exists.

## Figma Reference
`assets/references/01_splash.png`

## Required UI Components
| Section | Component | Data Type | Description |
|---|---|---|---|
| Body | App Name | Label | Displays the application name. |

## User Flow
1. The user opens the application.
2. The system displays Splash Screen.
3. The system initializes local resources.
4. The system checks the saved login session.
5. A valid session opens Home Screen.
6. A missing or expired session opens Login Screen.

## Navigation Flow
| Action | Destination |
|---|---|
| Valid session detected | Home Screen |
| No valid session | Login Screen |

## Business and Interaction Rules
- The screen has no interactive controls.
- Session checking may be simulated during the UI-only phase.

## Acceptance Criteria
- [ ] App name is visible.
- [ ] Session checking starts automatically.
- [ ] Valid session opens Home Screen.
- [ ] Invalid session opens Login Screen.
- [ ] No overflow occurs on a 360x800 screen.

## Implementation Constraints

- Use Flutter and Dart with Material 3.
- Use `SafeArea` where appropriate.
- Prefer responsive widgets such as `Column`, `Row`, `Expanded`, `Flexible`, `ListView`, `GridView`, and `LayoutBuilder`.
- Do not rebuild the whole screen with a full-screen `Stack` and absolute positioning.
- Reuse centralized theme tokens and shared widgets.
- Do not add UI elements not listed in this specification.
- Run `dart format .`, `flutter analyze`, and relevant tests before marking the screen complete.
