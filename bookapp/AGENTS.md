# AGENTS.md

## Project Overview

This project is a Flutter application named **Serene Reader**.

The application is a lightweight book reading app for educational purposes.

Main user flow:

Library Screen
→ Book Detail Screen
→ Table of Contents Screen
→ Reading Screen

The goal is to demonstrate:

* Book selection
* Chapter navigation
* Reading experience

No backend is required.

---

## Tech Stack

* Flutter
* Dart
* Material 3
* Navigator API
* StatefulWidget

Avoid introducing:

* Firebase
* REST API
* GraphQL
* Riverpod
* Bloc
* GetX
* Hive
* SQLite
* Supabase

Keep the implementation simple.

---

## Architecture

Use the following structure:

lib/
│
├── main.dart
│
├── models/
│   └── book.dart
│
├── data/
│   └── sample_data.dart
│
├── screens/
│   ├── library_screen.dart
│   ├── book_detail_screen.dart
│   ├── table_of_contents_screen.dart
│   └── reading_screen.dart
│
└── widgets/

---

## Coding Rules

### Simplicity First

Prefer:

* Simple code
* Readable code
* Educational code

Avoid:

* Over-engineering
* Complex abstractions
* Generic repositories
* Dependency injection

---

### Comments

Add concise comments.

Good:

// Navigate to reading page

Bad:

// This function is responsible for handling navigation behavior when the user taps...

---

### State Management

Use:

* StatefulWidget
* setState()

Avoid:

* Bloc
* Riverpod
* Redux
* MobX

---

## UI Guidelines

Style:

* Minimalist
* Reading focused
* Clean typography
* Soft rounded corners

Colors:

Background:
#F8F6F2

Primary:
#0B4F1C

Text:
#1F1F1F

Border Radius:
16-24

Spacing:
16-24

---

## Required Features

### Library Screen

Must include:

* Search bar
* Continue Reading card
* Book grid

User can select a book.

---

### Book Detail Screen

Must include:

* Cover image
* Title
* Author
* Description

Buttons:

* Read Now
* Table of Contents

---

### Table Of Contents Screen

Must include:

* Chapter list
* Current chapter highlight

User can open any chapter.

---

### Reading Screen

Must include:

* Chapter title
* Book content
* Progress indicator
* Bookmark button

Bookmark can be local state only.

---

## Sample Data

Always use hardcoded data.

Books:

* Suối Nguồn
* Nhà Giả Kim
* Hoàng Tử Bé
* Sapiens

Generate fake chapter content when needed.

---

## Output Requirements

When generating code:

1. Generate complete runnable files.
2. Do not leave TODO placeholders.
3. Do not omit imports.
4. Ensure code compiles.
5. Preserve existing project structure.
6. Prefer modifying existing files instead of creating unnecessary files.
7. Explain major changes briefly after code generation.

---

## Success Criteria

The application is considered complete when:

* User can select a book.
* User can view table of contents.
* User can read a chapter.
* Navigation works correctly.
* Project runs with `flutter run`.
