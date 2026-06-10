# Login Screen

## Purpose
The Login Screen authenticates users before they access Origami Master. Users can sign in with email and password or continue with Google.

## Figma Reference
`assets/references/02_login.png`

## Required UI Components
| Section | Component | Data Type | Description |
|---|---|---|---|
| Header | App Logo | Image | Displays the application identity. |
| Body | Welcome Text | Label | Introduces the Origami Master experience. |
| Body | Email Input | Text Field | Accepts an email address. |
| Body | Password Input | Password Field | Accepts a password securely. |
| Body | Continue Button | Primary Button | Submits email and password. |
| Body | Google Login Button | OAuth Button | Authenticates with Google. |
| Footer | Terms Text | Label | Displays terms and privacy notice. |

## User Flow
1. The system renders Login Screen.
2. The user enters credentials or chooses Google login.
3. The system validates authentication.
4. Successful authentication stores the session and opens Home Screen.
5. Failed authentication displays an error and remains on Login Screen.

## Navigation Flow
| Action | Destination |
|---|---|
| Login successful | Home Screen |
| Google login successful | Home Screen |
| Login failed | Login Screen |

## Business and Interaction Rules
- Password text must be obscured.
- Authentication may use mock behavior in the UI-only phase.

## Acceptance Criteria
- [ ] Email and password fields are visible.
- [ ] Continue and Google login buttons are visible.
- [ ] Successful login opens Home Screen.
- [ ] Failed login shows feedback.

## Implementation Constraints

- Use Flutter and Dart with Material 3.
- Use `SafeArea` where appropriate.
- Prefer responsive widgets such as `Column`, `Row`, `Expanded`, `Flexible`, `ListView`, `GridView`, and `LayoutBuilder`.
- Do not rebuild the whole screen with a full-screen `Stack` and absolute positioning.
- Reuse centralized theme tokens and shared widgets.
- Do not add UI elements not listed in this specification.
- Run `dart format .`, `flutter analyze`, and relevant tests before marking the screen complete.
