# ARCHITECTURE

## Why Clean Architecture

Clean Architecture enforces strict boundaries between UI, business rules, and data access. This project uses it to keep task rules independent from Hive and Flutter widgets, which makes features easier to test and evolve.

## Why Riverpod

Riverpod provides compile-safe dependency/state access, predictable state updates, and strong testability. `StateNotifier` is used for the ViewModel pattern so async loading/error/data transitions remain explicit and observable.

## Why Hive

Hive is lightweight, fast, and suitable for offline-first local storage in Flutter. It has low overhead, simple box CRUD semantics, and supports typed adapters for stable persistence.

## Tradeoffs

- Clean Architecture introduces more files and abstractions, but scales better than tightly coupled code.
- Riverpod has a learning curve for newcomers, but improves long-term maintainability.
- Hive is local-only; syncing/multi-device support would require additional layers.
- Manual adapter code avoids generators here, but generated adapters can reduce boilerplate in larger apps.
