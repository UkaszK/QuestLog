# QuestLog

QuestLog is a mobile Flutter app for daily planning, task management, and routine analysis. Tasks are organized as **Main Quests** and **Side Quests**. Progress tracking, streaks, and achievements add a playful framework to everyday planning.

The complete technical project overview is available in [SUMMARY.md](docs/SUMMARY.md).

## AI Usage

In a few selected cases, AI-assisted tools supported the development and documentation of QuestLog. All AI-generated contributions were reviewed and adapted by the project author.

## Features

- **Dashboard:** Daily view with date selection, daily progress, scheduled Main Quests, and Side Quests.
- **Assembler:** Time-based daily planning with editable time slots, quest assignment, and overlap detection.
- **Backlog:** Quest collection grouped by category, with filters for all quests, Main Quests, Side Quests, high priority, and quests due today.
- **Quest forms:** Create Main Quests and Side Quests with titles, notes, categories, priorities, durations, due dates, repetition schedules, and subtasks.
- **Analytics:** Progress metrics, daily completions, weekday comparisons, category breakdowns, habit consistency, and schedule distribution.
- **Achievements:** Badges, streaks, and progress tracking. Unlocked achievements are stored locally.
- **Offline-first:** The app stores its data locally and does not require a network connection for its core features.

## Technology

- [Flutter](https://flutter.dev) with Dart SDK `^3.11.4`
- [Riverpod](https://riverpod.dev/) for reactive state management
- [Isar](https://isar.dev/) as the local NoSQL database
- [`fl_chart`](https://pub.dev/packages/fl_chart) for analytics charts
- [`google_fonts`](https://pub.dev/packages/google_fonts) for UI typography

## Prerequisites

- Flutter SDK with Dart SDK `^3.11.4`
- A configured Android or iOS toolchain
- For iOS: macOS, Xcode, and CocoaPods
- For Android: Android Studio or the Android SDK

Check the installed Flutter version with:

```bash
flutter --version
```

## Installation and Usage

```bash
git clone <repository-url>
cd QuestLog
flutter pub get
flutter run
```

Available target devices can be checked with `flutter devices`. The standard Flutter commands can be used to create release builds:

```bash
flutter build apk       # Android
flutter build ios       # iOS auf macOS mit Xcode
```

## Code Generation

The Isar models use annotated classes to generate files such as `main_quest.g.dart` and `side_quest.g.dart`. Run code generation again after changing an annotated data model:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Generated `*.g.dart` files should not be edited manually.

## Architecture

The entry point is [`lib/main.dart`](lib/main.dart). On startup, the local Isar database is opened and the app is then started inside a Riverpod `ProviderScope`.

```text
lib/
├── data/       Isar models, enums, and metrics
├── providers/  Riverpod providers and controllers
├── screens/    Dashboard, Assembler, Backlog, Analytics, and forms
├── theme/      QuestLog colors and theme constants
├── utils/      Date and time helper functions
└── widgets/    Reusable UI components
```

The main layers are:

- `lib/data/` defines quests, scheduling, achievements, and analytics metrics.
- `lib/data/isar_data_store.dart` encapsulates database initialization, reading, writing, updating, archiving, and deletion.
- `lib/providers/` connects Isar watchers to the screens and computes feature-specific state.
- `lib/screens/` contains the visible app areas.
- `lib/widgets/` contains forms, charts, quest blocks, and shared layout components.

## Data and Privacy

QuestLog uses a local Isar database in the app documents directory. The current project does not include documented cloud synchronization or a server API. The data therefore does not leave the device through a network interface implemented by QuestLog.

Use the following commands for a quick local check:

```bash
flutter analyze
flutter test
```

`flutter test` may complete successfully without any tests, but it will not provide meaningful test coverage.

## Project Context

QuestLog was created as part of a Media Informatics project at HTW Berlin.