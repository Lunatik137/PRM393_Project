# Shared Links Screen

## Purpose
The Shared Links Screen lets users view and manage all generated links, copy active links, open shared previews, and disable or remove links.

## Figma Reference
`assets/references/11_shared_links.png`

## Required UI Components
| Section | Component | Data Type | Description |
|---|---|---|---|
| Header | Back Button | Icon Button | Returns to Profile or Generate Share Link. |
| Header | Screen Title | Label | Displays Shared Links. |
| Body | Shared Link List | List | Shows all links owned by current user. |
| Body | Shared Link Card | Card | Shows preview, name, date, and status. |
| Action | Copy Button | Icon Button | Copies an active link. |
| Action | Delete Button | Icon Button | Disables or removes a link. |

## User Flow
1. The user opens Shared Links.
2. The system loads all generated links.
3. The user copies, opens, or deletes a link.
4. Deleted active links become inactive and reject future access.
5. The list refreshes.

## Navigation Flow
| Action | Destination |
|---|---|
| Tap copy link | Shared Links Screen with copied confirmation |
| Tap delete link | Shared Links Screen with disabled confirmation |
| Tap shared link item | Shared Creation Screen |
| Tap back button | Profile Screen or Generate Share Link Screen |

## Business and Interaction Rules
- Disabled links cannot open valid shared content.
- Copy is disabled for inactive links.
- Delete or disable requires confirmation.

## Acceptance Criteria
- [ ] All owned links are listed.
- [ ] Active and disabled states are visible.
- [ ] Copy works only for active links.
- [ ] Delete updates status.
- [ ] Active card opens Shared Creation Screen.

## Implementation Constraints

- Use Flutter and Dart with Material 3.
- Use `SafeArea` where appropriate.
- Prefer responsive widgets such as `Column`, `Row`, `Expanded`, `Flexible`, `ListView`, `GridView`, and `LayoutBuilder`.
- Do not rebuild the whole screen with a full-screen `Stack` and absolute positioning.
- Reuse centralized theme tokens and shared widgets.
- Do not add UI elements not listed in this specification.
- Run `dart format .`, `flutter analyze`, and relevant tests before marking the screen complete.
