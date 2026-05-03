# AI_LOG

## Entry 1
- Prompt: Create Clean Architecture folder structure for Flutter app.
- AI response summary: Proposed `core` and `features/task` split with data/domain/presentation.
- Decision: accepted
- Reason: Matches scalable feature-first architecture.

## Entry 2
- Prompt: Implement Hive model and adapter for task storage.
- AI response summary: Added `TaskModel` with manual `TypeAdapter`.
- Decision: accepted
- Reason: Avoids generator dependency and keeps setup simple.

## Entry 3
- Prompt: Build local data source CRUD using Hive.
- AI response summary: Added box-based CRUD with exception wrapping.
- Decision: accepted
- Reason: Encapsulates storage and centralizes errors.

## Entry 4
- Prompt: Implement repository with failure mapping.
- AI response summary: Wrapped datasource exceptions into typed failures.
- Decision: accepted
- Reason: Required for clean error handling at domain/UI layers.

## Entry 5
- Prompt: Add domain use cases for task operations.
- AI response summary: Created get/add/update/delete use cases.
- Decision: accepted
- Reason: Keeps domain logic reusable and testable.

## Entry 6
- Prompt: Generate Riverpod TaskViewModel with loading/error/data states.
- AI response summary: Added `TaskState` and `TaskViewModel` with async state updates.
- Decision: modified
- Reason: Tweaked transitions for clearer error reset behavior.

## Entry 7
- Prompt: Build task list and add/edit screens with navigation.
- AI response summary: Added responsive Material screens and routing flow.
- Decision: accepted
- Reason: Covers required UX and edit/create flow.

## Entry 8
- Prompt: Add AI title suggestion feature without API.
- AI response summary: Added deterministic suggestion logic and gym example.
- Decision: accepted
- Reason: Meets requirement and remains fully offline.

## Entry 9
- Prompt: Introduce global exception/failure classes.
- AI response summary: Added `AppException` and typed `Failure` classes.
- Decision: accepted
- Reason: Improves user-friendly error propagation.

## Entry 10
- Prompt: Add repository and use case unit tests.
- AI response summary: Added tests for empty, invalid input, and failure cases.
- Decision: accepted
- Reason: Validates core business and data behavior.

## Entry 11
- Prompt: Suggest adding remote API integration now.
- AI response summary: Proposed immediate network client abstraction.
- Decision: rejected
- Reason: Out of scope for local-first requirement.

## Entry 12
- Prompt: Replace Riverpod with Bloc for state management.
- AI response summary: Suggested Bloc migration templates.
- Decision: rejected
- Reason: Conflicts with explicit Riverpod requirement.
