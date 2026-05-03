import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_task_manager/core/utils/result.dart';
import 'package:smart_task_manager/features/task/domain/entities/task.dart';
import 'package:smart_task_manager/features/task/domain/repositories/task_repository.dart';
import 'package:smart_task_manager/features/task/domain/usecases/add_task.dart';
import 'package:smart_task_manager/features/task/domain/usecases/delete_task.dart';
import 'package:smart_task_manager/features/task/domain/usecases/get_tasks.dart';
import 'package:smart_task_manager/features/task/domain/usecases/update_task.dart';
import 'package:smart_task_manager/features/task/presentation/screens/task_list_screen.dart';
import 'package:flutter/material.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late MockTaskRepository repository;
  final locator = GetIt.instance;

  setUp(() {
    locator.reset();
    repository = MockTaskRepository();
    locator.registerLazySingleton(() => GetTasks(repository));
    locator.registerLazySingleton(() => AddTask(repository));
    locator.registerLazySingleton(() => UpdateTask(repository));
    locator.registerLazySingleton(() => DeleteTask(repository));
  });

  testWidgets('renders list when tasks are available', (tester) async {
    when(() => repository.getTasks()).thenAnswer(
      (_) async => Result.success([
        Task(
          id: '1',
          title: 'Gym',
          description: 'Evening workout',
          isCompleted: false,
          createdAt: DateTime(2026),
        ),
      ]),
    );

    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: TaskListScreen())),
    );
    await tester.pumpAndSettle();

    expect(find.text('Gym'), findsOneWidget);
    expect(find.text('Evening workout'), findsOneWidget);
  });

  testWidgets('shows empty state when there are no tasks', (tester) async {
    when(
      () => repository.getTasks(),
    ).thenAnswer((_) async => Result.success([]));

    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: TaskListScreen())),
    );
    await tester.pumpAndSettle();

    expect(find.text('No tasks yet. Tap + to add one.'), findsOneWidget);
  });

  testWidgets('shows loading state while fetching tasks', (tester) async {
    final completer = Completer<Result<List<Task>>>();
    when(() => repository.getTasks()).thenAnswer((_) => completer.future);

    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: TaskListScreen())),
    );
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    completer.complete(Result.success(<Task>[]));
    await tester.pumpAndSettle();
  });

  testWidgets('supports user interaction to delete task', (tester) async {
    when(() => repository.getTasks()).thenAnswer(
      (_) async => Result.success([
        Task(
          id: '1',
          title: 'Call mom',
          description: '',
          isCompleted: false,
          createdAt: DateTime(2026),
        ),
      ]),
    );
    when(
      () => repository.deleteTask('1'),
    ).thenAnswer((_) async => Result.success(null));

    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: TaskListScreen())),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();

    verify(() => repository.deleteTask('1')).called(1);
  });
}
