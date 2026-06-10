# Shared Creation Screen

## Purpose
The Shared Creation Screen displays a creation in read-only mode through a private link. The token must be valid and active; otherwise, the unavailable state is shown.

## Figma Reference
`assets/references/12_shared_creation.png`

## Required UI Components
| Section | Component | Data Type | Description |
|---|---|---|---|
| Header | App Name | Label | Shows Origami Master branding. |
| Body | Shared Creation Image | Image | Displays shared creation. |
| Body | Fold Model Name | Label | Shows related model. |
| Body | Creator Nickname | Label | Shows creator display name. |
| Body | Completion Date | Label | Shows completion date. |
| Body | Read-only Notice | Info Text | Indicates no editing is allowed. |
| Body | Unavailable Link State | Status View | Shows invalid, expired, disabled, or deleted state. |

## User Flow
1. A viewer opens the shared URL.
2. The system validates the token and active status.
3. A valid link displays the creation in read-only mode.
4. An invalid link displays the unavailable state.
5. The viewer cannot edit, delete, change visibility, or generate another link.

## Navigation Flow
| Action | Destination |
|---|---|
| Open valid link | Shared Creation Screen |
| Open invalid, expired, disabled, or deleted link | Link Expired / Not Found State |

## Business and Interaction Rules
- Always read-only.
- No owner management controls.
- Validate token before displaying creation.

## Acceptance Criteria
- [ ] Valid token shows creation information.
- [ ] Invalid token shows unavailable state.
- [ ] No edit, delete, visibility, or share-generation controls appear.

## Implementation Constraints

- Use Flutter and Dart with Material 3.
- Use `SafeArea` where appropriate.
- Prefer responsive widgets such as `Column`, `Row`, `Expanded`, `Flexible`, `ListView`, `GridView`, and `LayoutBuilder`.
- Do not rebuild the whole screen with a full-screen `Stack` and absolute positioning.
- Reuse centralized theme tokens and shared widgets.
- Do not add UI elements not listed in this specification.
- Run `dart format .`, `flutter analyze`, and relevant tests before marking the screen complete.
