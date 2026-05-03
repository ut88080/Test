import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_task_manager/core/error/failures.dart';
import 'package:smart_task_manager/core/usecases/usecase.dart';
import 'package:smart_task_manager/core/utils/result.dart';
import 'package:smart_task_manager/features/task/domain/entities/task.dart';
import 'package:smart_task_manager/features/task/domain/repositories/task_repository.dart';
import 'package:smart_task_manager/features/task/domain/usecases/add_task.dart';
import 'package:smart_task_manager/features/task/domain/usecases/delete_task.dart';
import 'package:smart_task_manager/features/task/domain/usecases/get_tasks.dart';
import 'package:smart_task_manager/features/task/domain/usecases/update_task.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late MockTaskRepository repository;
  late Task sampleTask;

  setUpAll(() {
    registerFallbackValue(
      Task(
        id: 'fallback',
        title: 'fallback',
        description: 'fallback',
        isCompleted: false,
        createdAt: DateTime(2026),
      ),
    );
  });

  setUp(() {
    repository = MockTaskRepository();
    sampleTask = Task(
      id: '1',
      title: 'Workout',
      description: 'Go to gym',
      isCompleted: false,
      createdAt: DateTime(2026),
    );
  });

  test('GetTasks returns empty list success', () async {
    when(
      () => repository.getTasks(),
    ).thenAnswer((_) async => Result.success([]));
    final usecase = GetTasks(repository);

    final result = await usecase(const NoParams());

    expect(result.isSuccess, true);
    expect(result.data, isEmpty);
  });

  test('AddTask returns validation failure on empty title', () async {
    final usecase = AddTask(repository);
    final invalid = sampleTask.copyWith(title: '   ');

    final result = await usecase(invalid);

    expect(result.isSuccess, false);
    expect(result.failure, isA<ValidationFailure>());
    verifyNever(() => repository.addTask(any()));
  });

  test('UpdateTask propagates repository failure', () async {
    when(() => repository.updateTask(any())).thenAnswer(
      (_) async => Result.error(const CacheFailure('Update failed')),
    );
    final usecase = UpdateTask(repository);

    final result = await usecase(sampleTask);

    expect(result.isSuccess, false);
    expect(result.failure?.message, 'Update failed');
  });

  test('DeleteTask calls repository once', () async {
    when(
      () => repository.deleteTask(any()),
    ).thenAnswer((_) async => Result.success(null));
    final usecase = DeleteTask(repository);

    final result = await usecase('1');

    expect(result.isSuccess, true);
    verify(() => repository.deleteTask('1')).called(1);
  });
}
