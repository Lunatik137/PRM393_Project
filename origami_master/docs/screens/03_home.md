# Home Screen

## Purpose
The Home Screen is the main dashboard. It lets users discover a featured fold, continue an unfinished tutorial, view recent public community creations, and navigate to the main app sections.

## Figma Reference
`assets/references/03_home.png`

## Required UI Components
| Section | Component | Data Type | Description |
|---|---|---|---|
| Header | App Logo | Image | Displays application identity. |
| Header | Profile Avatar | Image Button | Opens Profile Screen. |
| Body | Featured Fold Card | Card | Displays a highlighted lesson. |
| Body | Continue Learning Card | Card | Shows saved lesson progress. |
| Body | Recent Community Creations | Horizontal Card List | Shows recently published public creations. |
| Bottom | Bottom Navigation Bar | Navigation | Provides Home, Explore, Gallery, and Profile. |

## User Flow
1. The user enters Home Screen after login.
2. The system loads featured fold, saved progress, and recent public creations.
3. The user opens a fold, resumes learning, or views a community creation.
4. The user may use bottom navigation.

## Navigation Flow
| Action | Destination |
|---|---|
| Tap featured fold | Fold Detail Screen |
| Tap continue learning | Learning Step Screen |
| Tap community creation | Creation Detail Screen |
| Tap Explore tab | Explore Screen |
| Tap Gallery tab | Gallery Screen |
| Tap Profile tab | Profile Screen |

## Business and Interaction Rules
- Community items must be public.
- No Daily Challenge, achievements, badges, ranks, or streaks.

## Acceptance Criteria
- [ ] Featured fold is visible.
- [ ] Continue Learning shows progress.
- [ ] Recent Community Creations is visible.
- [ ] Bottom navigation has exactly four tabs.
- [ ] All navigation actions work.

## Implementation Constraints

- Use Flutter and Dart with Material 3.
- Use `SafeArea` where appropriate.
- Prefer responsive widgets such as `Column`, `Row`, `Expanded`, `Flexible`, `ListView`, `GridView`, and `LayoutBuilder`.
- Do not rebuild the whole screen with a full-screen `Stack` and absolute positioning.
- Reuse centralized theme tokens and shared widgets.
- Do not add UI elements not listed in this specification.
- Run `dart format .`, `flutter analyze`, and relevant tests before marking the screen complete.
