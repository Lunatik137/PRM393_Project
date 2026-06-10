# Gallery Screen

## Purpose
The Gallery Screen shows and manages all completed creations owned by the current user, including public and private creations.

## Figma Reference
`assets/references/08_gallery.png`

## Required UI Components
| Section | Component | Data Type | Description |
|---|---|---|---|
| Header | Screen Title | Label | Displays My Gallery. |
| Header | Search Bar | Text Input | Searches creations by fold name. |
| Filter | Fold Type Filter | Filter Chips | Filters by model, category, or visibility. |
| Body | Creation Grid | Grid List | Displays the current user's creations. |
| Body | Creation Card | Card | Shows image, fold name, date, and visibility. |
| Bottom | Bottom Navigation Bar | Navigation | Provides Home, Explore, Gallery, and Profile. |

## User Flow
1. The user opens Gallery Screen.
2. The system loads the current user's creations.
3. The user searches or filters.
4. The grid updates.
5. The user opens a creation card.

## Navigation Flow
| Action | Destination |
|---|---|
| Tap creation card | Creation Detail Screen |
| Tap Home tab | Home Screen |
| Tap Explore tab | Explore Screen |
| Tap Profile tab | Profile Screen |

## Business and Interaction Rules
- Only creations owned by the current user appear.
- Each card shows Public or Private status.

## Acceptance Criteria
- [ ] Public and private creations appear.
- [ ] Search and filters work.
- [ ] Creation card opens Creation Detail Screen.
- [ ] Gallery is the active tab.

## Implementation Constraints

- Use Flutter and Dart with Material 3.
- Use `SafeArea` where appropriate.
- Prefer responsive widgets such as `Column`, `Row`, `Expanded`, `Flexible`, `ListView`, `GridView`, and `LayoutBuilder`.
- Do not rebuild the whole screen with a full-screen `Stack` and absolute positioning.
- Reuse centralized theme tokens and shared widgets.
- Do not add UI elements not listed in this specification.
- Run `dart format .`, `flutter analyze`, and relevant tests before marking the screen complete.
