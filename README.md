# Smart Task Manager (AI Assisted)

Smart Task Manager is a Flutter productivity app that demonstrates production-style Clean Architecture + MVVM with local persistence and AI-assisted task title suggestion logic.

## Setup Steps

1. Install Flutter 3.35+ and Dart 3.10+.
2. Run `flutter pub get`.
3. Run the app with `flutter run`.
4. Execute checks:
   - `flutter analyze`
   - `flutter test`

## Tech Stack

- Flutter (Material 3 UI)
- Riverpod (`StateNotifierProvider`) for state management
- Hive for local persistence
- GetIt for dependency injection
- Mocktail + Flutter test for unit/widget tests

## Architecture

The app uses Clean Architecture with clear boundaries:

- `core`: shared app-wide concerns (`error`, `utils`, `usecases`, `services`)
- `features/task/data`: model, local data source, repository implementation
- `features/task/domain`: entities, repository contract, use cases
- `features/task/presentation`: Riverpod ViewModel, screens, providers

This keeps business logic independent from UI and storage, making the codebase scalable and testable.

## AI Usage Reflection

The AI-assisted feature is intentionally mock logic to avoid network dependency and API complexity in this baseline build. It improves short task inputs with contextual suggestions and is easy to replace with a real model later. AI also helped accelerate scaffolding and repetitive boilerplate, while architecture, tradeoff, and error-handling decisions were validated and adjusted manually.
# Test
