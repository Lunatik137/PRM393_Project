# Generate Share Link Screen

## Purpose
The Generate Share Link Screen creates a private URL for a selected creation. Anyone with a valid active link can view it, even when the creation is private.

## Figma Reference
`assets/references/10_generate_share_link.png`

## Required UI Components
| Section | Component | Data Type | Description |
|---|---|---|---|
| Header | Back Button | Icon Button | Returns to previous screen. |
| Body | Creation Preview | Image Card | Displays selected creation. |
| Body | Privacy Notice | Info Card | Explains link-only access. |
| Body | Generated Link Field | Read-only Text Field | Displays generated URL. |
| Footer | Generate Link Button | Primary Button | Creates and stores a unique link. |
| Footer | Copy Link Button | Button | Copies URL. |
| Footer | View Shared Links | Text Button | Opens Shared Links Screen. |

## User Flow
1. The user opens the screen from Completion Result or Creation Detail.
2. The system shows the creation preview.
3. The user generates a link.
4. The system stores the active link.
5. The URL is displayed.
6. The user may copy it or view all shared links.

## Navigation Flow
| Action | Destination |
|---|---|
| Tap back button | Completion Result Screen or Creation Detail Screen |
| Tap Generate Link | Generate Share Link Screen with generated URL |
| Tap Copy Link | Generate Share Link Screen with copied confirmation |
| Tap View Shared Links | Shared Links Screen |

## Business and Interaction Rules
- Generated links must be unique.
- Public and private creations may generate links.
- Copy is enabled only after a link exists.

## Acceptance Criteria
- [ ] Preview is visible.
- [ ] Generate Link creates and displays a URL.
- [ ] Copy shows confirmation.
- [ ] View Shared Links opens Shared Links Screen.

## Implementation Constraints

- Use Flutter and Dart with Material 3.
- Use `SafeArea` where appropriate.
- Prefer responsive widgets such as `Column`, `Row`, `Expanded`, `Flexible`, `ListView`, `GridView`, and `LayoutBuilder`.
- Do not rebuild the whole screen with a full-screen `Stack` and absolute positioning.
- Reuse centralized theme tokens and shared widgets.
- Do not add UI elements not listed in this specification.
- Run `dart format .`, `flutter analyze`, and relevant tests before marking the screen complete.
