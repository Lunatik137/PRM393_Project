# Creation Detail Screen

## Purpose
The Creation Detail Screen shows complete creation information. Owner creations include management actions, while community creations are read-only.

## Figma Reference
`assets/references/09_creation_detail.png`

## Required UI Components
| Section | Component | Data Type | Description |
|---|---|---|---|
| Header | Back Button | Icon Button | Returns to the previous screen. |
| Hero | Creation Image | Image | Displays completed photo. |
| Hero | Visibility Status Badge | Badge | Displays Public or Private. |
| Body | Fold Name | Label | Shows related model. |
| Body | Creator Avatar | Image | Shows owner profile image. |
| Body | Creator Nickname | Label | Shows creator name. |
| Body | Completion Date | Label | Shows completion date. |
| Body | Creation Description | Text Block | Shows creator note. |
| Body | Edit Details Button | List Button | Edits creation details. |
| Body | Change Visibility Button | List Button | Switches Public or Private. |
| Body | Share Creation Button | Primary Button | Opens Generate Share Link Screen. |
| Body | Delete Creation Button | Text Button | Deletes after confirmation. |

## User Flow
1. The user opens a creation from Gallery, Home, or Community Gallery.
2. The system displays creation information.
3. Owner view shows management actions.
4. Community view is read-only.
5. The owner may edit, change visibility, share, or delete.

## Navigation Flow
| Action | Destination |
|---|---|
| Tap back button | Gallery Screen, Home Screen, or Fold Detail Screen |
| Tap Share Creation | Generate Share Link Screen |

## Business and Interaction Rules
- Owner-only controls must be hidden for other users' creations.
- Delete requires confirmation.
- Visibility changes update Community Gallery eligibility.

## Acceptance Criteria
- [ ] Creation details are visible.
- [ ] Owner view has management actions.
- [ ] Community view is read-only.
- [ ] Share opens Generate Share Link Screen.

## Implementation Constraints

- Use Flutter and Dart with Material 3.
- Use `SafeArea` where appropriate.
- Prefer responsive widgets such as `Column`, `Row`, `Expanded`, `Flexible`, `ListView`, `GridView`, and `LayoutBuilder`.
- Do not rebuild the whole screen with a full-screen `Stack` and absolute positioning.
- Reuse centralized theme tokens and shared widgets.
- Do not add UI elements not listed in this specification.
- Run `dart format .`, `flutter analyze`, and relevant tests before marking the screen complete.
