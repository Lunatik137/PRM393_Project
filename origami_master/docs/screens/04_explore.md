# Explore Screen

## Purpose
The Explore Screen lets users browse, search, and filter origami models before opening Fold Detail Screen.

## Figma Reference
`assets/references/04_explore.png`

## Required UI Components
| Section | Component | Data Type | Description |
|---|---|---|---|
| Header | Search Bar | Text Input | Searches models by name. |
| Filter | Category Chips | Horizontal List | Filters models by category. |
| Filter | Difficulty Filter | Filter Chips | Filters Easy, Medium, or Hard. |
| Body | Origami Grid | Grid List | Displays matching models. |
| Body | Fold Card | Card | Shows image, name, category, duration, and difficulty. |
| Bottom | Bottom Navigation Bar | Navigation | Provides Home, Explore, Gallery, and Profile. |

## User Flow
1. The user opens Explore Screen.
2. The system loads origami models.
3. The user searches or applies filters.
4. The system updates the grid.
5. The user selects a fold card.

## Navigation Flow
| Action | Destination |
|---|---|
| Tap fold card | Fold Detail Screen |
| Use search | Explore Screen with filtered results |
| Tap category or difficulty chip | Explore Screen with filtered results |
| Tap Home tab | Home Screen |
| Tap Gallery tab | Gallery Screen |
| Tap Profile tab | Profile Screen |

## Business and Interaction Rules
- Search and filters update the same screen.
- Do not add a separate Community tab.

## Acceptance Criteria
- [ ] Search and filters work.
- [ ] Grid updates correctly.
- [ ] Fold card opens Fold Detail Screen.
- [ ] Explore is the active tab.

## Implementation Constraints

- Use Flutter and Dart with Material 3.
- Use `SafeArea` where appropriate.
- Prefer responsive widgets such as `Column`, `Row`, `Expanded`, `Flexible`, `ListView`, `GridView`, and `LayoutBuilder`.
- Do not rebuild the whole screen with a full-screen `Stack` and absolute positioning.
- Reuse centralized theme tokens and shared widgets.
- Do not add UI elements not listed in this specification.
- Run `dart format .`, `flutter analyze`, and relevant tests before marking the screen complete.
