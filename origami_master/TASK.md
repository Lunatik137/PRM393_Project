# TASK.md - Origami Master Flutter UI

## Current Task

Set up the Flutter UI foundation for the Origami Master application.

This task focuses only on the first implementation layer:

* app structure
* theme system
* routing
* mock data foundation
* shared reusable widgets
* placeholder screens for navigation

Do not implement the full detailed UI of all screens yet.

---

## Project Context

Origami Master is a Flutter mobile application focused on:

1. Step-by-step origami learning.
2. Origami model detail pages.
3. Community gallery inside each Fold Detail screen.
4. User gallery of completed creations.
5. Private share links for user creations.
6. Achievement list.
7. Profile screen.

Current development phase:

```text
UI-first implementation
Mock data only
Local image assets only
Backend prepared for future
No real backend implementation yet
```

---

## Target Screens

The app will contain these screens:

1. Splash Screen
2. Login Screen
3. Home Screen
4. Explore Screen
5. Fold Detail Screen
6. Learning Step Screen
7. Completion Result Screen
8. Gallery Screen
9. Creation Detail Screen
10. Generate Share Link Screen
11. Shared Links Screen
12. Shared Creation Screen
13. Achievement List Screen
14. Profile Screen

---

## Scope for This Task

Implement only the foundation needed for the app.

### Must Implement

1. App entry structure
2. Theme system
3. Route definitions
4. Mock data models
5. Mock repositories
6. Shared layout widgets
7. Reusable UI components
8. Placeholder screens for all target screens
9. Bottom navigation shell for main tabs

---

## Required Folder Structure

Use this feature-first Flutter structure:

```text
lib/
├── main.dart
├── app/
│   ├── app.dart
│   ├── app_routes.dart
│   ├── app_theme.dart
│   └── app_shell.dart
├── core/
│   ├── constants/
│   ├── widgets/
│   └── utils/
├── data/
│   ├── models/
│   ├── repositories/
│   └── mock/
└── features/
    ├── auth/
    │   └── screens/
    ├── home/
    │   └── screens/
    ├── explore/
    │   └── screens/
    ├── fold_detail/
    │   └── screens/
    ├── learning/
    │   └── screens/
    ├── completion/
    │   └── screens/
    ├── gallery/
    │   └── screens/
    ├── sharing/
    │   └── screens/
    ├── achievement/
    │   └── screens/
    └── profile/
        └── screens/
```

---

## App Navigation

Use named routes.

Required routes:

```text
/splash
/login
/home
/explore
/fold-detail
/learning-step
/completion-result
/gallery
/creation-detail
/generate-share-link
/shared-links
/shared-creation
/achievements
/profile
```

Main bottom navigation tabs:

```text
Home
Explore
Gallery
Profile
```

Screens under bottom navigation:

```text
Home Screen
Explore Screen
Gallery Screen
Profile Screen
```

Secondary screens:

```text
Fold Detail Screen
Learning Step Screen
Completion Result Screen
Creation Detail Screen
Generate Share Link Screen
Shared Links Screen
Shared Creation Screen
Achievement List Screen
```

---

## Design System Requirements

Create a consistent Origami Master design system.

### Color Direction

Use warm Japanese paper-inspired colors:

```text
background: warm ivory / cream
primary: warm brown
secondary: muted gold
accent: soft olive
surface: paper white
text primary: dark brown
text secondary: warm gray
```

### UI Style

The app should feel:

```text
calm
premium
minimal
Japanese-inspired
paper-crafted
warm
elegant
```

### Shared Components to Create

At minimum, create these reusable widgets:

```text
AppScaffold
AppBottomNavBar
AppPrimaryButton
AppSecondaryButton
AppCard
SectionHeader
OrigamiCard
CreationCard
AchievementBadgeCard
ProgressRing
```

Use simple placeholder visuals for now.

---

## Data Models

Create basic models for future use:

```text
OrigamiModel
OrigamiStep
CommunityCreation
UserCreation
SharedLink
Achievement
UserProfile
```

Do not overcomplicate fields.

Minimum fields:

### OrigamiModel

```text
id
title
category
difficulty
durationMinutes
xpReward
imagePath
```

### OrigamiStep

```text
id
origamiId
stepNumber
title
description
imagePath
```

### CommunityCreation

```text
id
origamiId
creatorName
creatorAvatarPath
imagePath
completedAt
```

### UserCreation

```text
id
origamiId
title
imagePath
completedAt
xpEarned
```

### SharedLink

```text
id
creationId
token
url
createdAt
isActive
```

### Achievement

```text
id
title
description
xpReward
progressPercent
isUnlocked
iconPath
```

### UserProfile

```text
id
name
email
avatarPath
rank
totalXp
completedFolds
```

---

## Repository Layer

Prepare repository interfaces or mock repositories.

Create mock repositories for:

```text
OrigamiRepository
CreationRepository
ShareLinkRepository
AchievementRepository
UserRepository
```

For now, these repositories should return static mock data.

Important:
Do not call real API.
Do not add Firebase.
Do not add backend services.

---

## Placeholder Screen Requirements

Each placeholder screen should:

1. Compile successfully.
2. Show the screen name.
3. Use AppScaffold.
4. Follow the app theme.
5. Include basic navigation buttons where needed.

Examples:

```text
Home Screen
- button to Explore
- button to Fold Detail
- button to Profile

Explore Screen
- mock OrigamiCard list
- tap card navigates to Fold Detail

Fold Detail Screen
- show mock fold information
- show small mock community gallery section
- button to Learning Step

Learning Step Screen
- show step placeholder
- button to Completion Result

Completion Result Screen
- button to Generate Share Link
- button to Home

Gallery Screen
- show mock CreationCard list
- tap card navigates to Creation Detail

Creation Detail Screen
- button to Generate Share Link

Generate Share Link Screen
- button to Shared Links

Profile Screen
- button to Achievements
- button to Shared Links
```

---

## Important Business Rules

### Community Gallery Rule

In the future, the Fold Detail screen must show community creations for the selected origami model only.

Example:

```text
If selected fold is Crane:
show only Crane community creations.
```

For now, prepare mock data with `origamiId` so this rule can be implemented later.

### Private Share Link Rule

Shared Creation Screen is read-only.

Only users with a valid private link should view the shared creation in the future.

For now, simulate this using mock tokens.

---

## Out of Scope

Do not implement:

```text
real backend
Firebase
real Google login
real Apple login
image upload
camera
database
push notifications
AI features
complex animations
```

Do not redesign the app scope.

Do not add screens that are not listed in this task.

---

## Verification Commands

After coding, run:

```bash
flutter pub get
dart format .
flutter analyze
flutter test
```

If build verification is required:

```bash
flutter build apk --debug
```

---

## Definition of Done

This task is complete only when:

* The app runs successfully.
* All target routes exist.
* Placeholder screens for all 14 screens exist.
* Bottom navigation works for Home, Explore, Gallery, and Profile.
* Mock models and repositories exist.
* Shared widgets exist.
* Theme is applied globally.
* No analyzer errors.
* Existing tests pass.
* progress.md is updated with completed work.
