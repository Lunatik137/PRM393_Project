# Learning Step Screen

## Purpose
The Learning Step Screen guides users through an origami tutorial one step at a time and saves their progress.

## Figma Reference
`assets/references/06_learning_step.png`

## Required UI Components
| Section | Component | Data Type | Description |
|---|---|---|---|
| Header | Close Button | Icon Button | Returns to Fold Detail Screen. |
| Header | Step Counter | Label | Shows current and total steps. |
| Header | Progress Indicator | Progress Bar | Shows completion progress. |
| Body | Instruction Image | Image | Shows the current folding instruction. |
| Body | Step Title | Label | Shows the folding action. |
| Body | Step Description | Text Block | Explains the action. |
| Body | Pro Tip Card | Card | Shows a helpful tip. |
| Footer | Previous Button | Button | Opens the previous step. |
| Footer | Next Button | Primary Button | Opens the next step or finishes. |

## User Flow
1. The user starts or resumes a tutorial.
2. The system loads the first incomplete or saved step.
3. The user follows the instruction.
4. Previous and Next change steps.
5. Progress is saved after navigation.
6. The final step opens Completion Result Screen.

## Navigation Flow
| Action | Destination |
|---|---|
| Tap close button | Fold Detail Screen |
| Tap Previous | Previous step on Learning Step Screen |
| Tap Next | Next step on Learning Step Screen |
| Tap Next on final step | Completion Result Screen |

## Business and Interaction Rules
- Previous is disabled on the first step.
- Next becomes Finish on the final step.
- Saved progress and step counter must stay synchronized.

## Acceptance Criteria
- [ ] Step counter and progress bar match.
- [ ] Previous and Next work.
- [ ] Progress is saved.
- [ ] Final step opens Completion Result Screen.

## Implementation Constraints

- Use Flutter and Dart with Material 3.
- Use `SafeArea` where appropriate.
- Prefer responsive widgets such as `Column`, `Row`, `Expanded`, `Flexible`, `ListView`, `GridView`, and `LayoutBuilder`.
- Do not rebuild the whole screen with a full-screen `Stack` and absolute positioning.
- Reuse centralized theme tokens and shared widgets.
- Do not add UI elements not listed in this specification.
- Run `dart format .`, `flutter analyze`, and relevant tests before marking the screen complete.
