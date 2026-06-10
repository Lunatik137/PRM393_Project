# Completion Result Screen

## Purpose
The Completion Result Screen lets users review and save a completed creation, choose visibility, generate a private link, or continue. New creations are private by default.

## Figma Reference
`assets/references/07_completion_result.png`

## Required UI Components
| Section | Component | Data Type | Description |
|---|---|---|---|
| Header | Completion Title | Label | Displays success message. |
| Body | Completed Fold Image | Image | Shows result or uploaded photo. |
| Body | Completion Summary | Card | Shows fold name, date, and time spent. |
| Body | Visibility Setting Card | Card | Contains visibility controls. |
| Body | Publish to Community Toggle | Switch | Controls public visibility and is off by default. |
| Body | Visibility Description | Info Text | Explains public and private behavior. |
| Footer | Save Creation Button | Primary Button | Saves creation and visibility. |
| Footer | Generate Share Link Button | Button | Saves if needed and opens sharing. |
| Footer | Continue Journey Button | Text Button | Returns to Home Screen. |

## User Flow
1. The user completes the final tutorial step.
2. The system opens Completion Result Screen.
3. Visibility starts as Private.
4. The user may enable public visibility.
5. Save Creation stores the creation.
6. A public creation may appear in matching Community Gallery.
7. A private creation stays hidden but may still be shared by link.

## Navigation Flow
| Action | Destination |
|---|---|
| Tap Save Creation | Gallery Screen |
| Tap Generate Share Link | Generate Share Link Screen |
| Tap Continue Journey | Home Screen |

## Business and Interaction Rules
- `isPublic` must be false by default.
- Publishing requires explicit user action.
- Private creations can generate share links.

## Acceptance Criteria
- [ ] Toggle is off initially.
- [ ] Save stores selected visibility.
- [ ] Generate Share Link opens the correct screen.
- [ ] Continue Journey opens Home Screen.

## Implementation Constraints

- Use Flutter and Dart with Material 3.
- Use `SafeArea` where appropriate.
- Prefer responsive widgets such as `Column`, `Row`, `Expanded`, `Flexible`, `ListView`, `GridView`, and `LayoutBuilder`.
- Do not rebuild the whole screen with a full-screen `Stack` and absolute positioning.
- Reuse centralized theme tokens and shared widgets.
- Do not add UI elements not listed in this specification.
- Run `dart format .`, `flutter analyze`, and relevant tests before marking the screen complete.
