# Fold Detail Screen

## Purpose
The Fold Detail Screen shows full information about a selected origami model, including materials, difficulty, duration, step preview, and matching public community creations.

## Figma Reference
`assets/references/05_fold_detail.png`

## Required UI Components
| Section | Component | Data Type | Description |
|---|---|---|---|
| Header | Back Button | Icon Button | Returns to the previous screen. |
| Hero | Fold Image | Image | Displays the completed model. |
| Info | Fold Title | Label | Displays the model name. |
| Info | Category Label | Label | Displays the category. |
| Info | Difficulty Badge | Badge | Displays difficulty. |
| Info | Estimated Time | Label | Displays expected duration. |
| Materials | Material List | List | Shows paper size, type, and optional tools. |
| Steps | Step Preview | Timeline | Shows tutorial overview. |
| Community | Community Gallery | Horizontal/Grid List | Shows matching public creations. |
| Footer | Start Learning Button | Primary Button | Starts or resumes tutorial. |

## User Flow
1. The user opens Fold Detail from Home or Explore.
2. The system displays fold information.
3. The system loads creations where `isPublic == true` and `origamiId` matches.
4. The user may open a community creation.
5. The user starts or resumes the tutorial.

## Navigation Flow
| Action | Destination |
|---|---|
| Tap back button | Home Screen or Explore Screen |
| Tap Start Learning | Learning Step Screen |
| Tap community creation | Creation Detail Screen |

## Business and Interaction Rules
- Community query must use public status and matching origami ID.
- Do not show bottom navigation.

## Acceptance Criteria
- [ ] Fold details and materials are visible.
- [ ] Community Gallery contains only matching public creations.
- [ ] Start Learning opens Learning Step Screen.
- [ ] Back returns to the source screen.

## Implementation Constraints

- Use Flutter and Dart with Material 3.
- Use `SafeArea` where appropriate.
- Prefer responsive widgets such as `Column`, `Row`, `Expanded`, `Flexible`, `ListView`, `GridView`, and `LayoutBuilder`.
- Do not rebuild the whole screen with a full-screen `Stack` and absolute positioning.
- Reuse centralized theme tokens and shared widgets.
- Do not add UI elements not listed in this specification.
- Run `dart format .`, `flutter analyze`, and relevant tests before marking the screen complete.
