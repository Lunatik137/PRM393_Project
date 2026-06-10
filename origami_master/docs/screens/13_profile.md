# Profile Screen

## Purpose
The Profile Screen shows account information and creation statistics and provides access to Shared Links, Settings, Logout, and main navigation.

## Figma Reference
`assets/references/13_profile.png`

## Required UI Components
| Section | Component | Data Type | Description |
|---|---|---|---|
| Header | Avatar | Image | Displays user profile image. |
| Header | Username | Label | Displays user name. |
| Body | Completed Folds Count | Label | Shows completed lessons. |
| Body | Public Creations Count | Label | Shows public creations. |
| Body | Shared Links Button | Button | Opens Shared Links Screen. |
| Body | Settings Button | Button | Opens local preferences. |
| Body | Logout Button | Button | Clears session and opens Login Screen. |
| Bottom | Bottom Navigation Bar | Navigation | Provides Home, Explore, Gallery, and Profile. |

## User Flow
1. The user opens Profile Screen.
2. The system loads profile data and statistics.
3. The user may open Shared Links or Settings.
4. The user may log out.
5. The user may use bottom navigation.

## Navigation Flow
| Action | Destination |
|---|---|
| Tap Shared Links | Shared Links Screen |
| Tap Settings | Settings Screen / Preference Dialog |
| Tap Logout | Login Screen |
| Tap Home tab | Home Screen |
| Tap Explore tab | Explore Screen |
| Tap Gallery tab | Gallery Screen |

## Business and Interaction Rules
- Do not show achievements, rank, streak, XP, or private creation count.
- Logout requires confirmation.
- Profile is the active tab.

## Acceptance Criteria
- [ ] Avatar and username are visible.
- [ ] Completed Folds and Public Creations counts are visible.
- [ ] Shared Links opens correctly.
- [ ] Settings opens correctly.
- [ ] Logout clears session and opens Login Screen.
- [ ] Bottom navigation works.

## Implementation Constraints

- Use Flutter and Dart with Material 3.
- Use `SafeArea` where appropriate.
- Prefer responsive widgets such as `Column`, `Row`, `Expanded`, `Flexible`, `ListView`, `GridView`, and `LayoutBuilder`.
- Do not rebuild the whole screen with a full-screen `Stack` and absolute positioning.
- Reuse centralized theme tokens and shared widgets.
- Do not add UI elements not listed in this specification.
- Run `dart format .`, `flutter analyze`, and relevant tests before marking the screen complete.
