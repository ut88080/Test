import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_task_manager/core/error/exceptions.dart';
import 'package:smart_task_manager/core/error/failures.dart';
import 'package:smart_task_manager/features/task/data/datasources/task_local_data_source.dart';
import 'package:smart_task_manager/features/task/data/models/task_model.dart';
import 'package:smart_task_manager/features/task/data/repositories/task_repository_impl.dart';
import 'package:smart_task_manager/features/task/domain/entities/task.dart';

class MockTaskLocalDataSource extends Mock implements TaskLocalDataSource {}

void main() {
  late MockTaskLocalDataSource dataSource;
  late TaskRepositoryImpl repository;
  late Task task;

  setUpAll(() {
    registerFallbackValue(
      TaskModel(
        id: 'fallback',
        title: 'fallback',
        description: 'fallback',
        isCompleted: false,
        createdAt: DateTime(2026),
      ),
    );
  });

  setUp(() {
    dataSource = MockTaskLocalDataSource();
    repository = TaskRepositoryImpl(localDataSource: dataSource);
    task = Task(
      id: 'id-1',
      title: 'Task',
      description: 'Description',
      isCompleted: false,
      createdAt: DateTime(2026),
    );
  });

  test('returns empty list when no local tasks exist', () async {
    when(() => dataSource.getTasks()).thenAnswer((_) async => []);

    final result = await repository.getTasks();

    expect(result.isSuccess, true);
    expect(result.data, isEmpty);
  });

  test('maps CacheException to CacheFailure', () async {
    when(
      () => dataSource.getTasks(),
    ).thenThrow(const CacheException('Could not fetch tasks.'));

    final result = await repository.getTasks();

    expect(result.isSuccess, false);
    expect(result.failure, isA<CacheFailure>());
  });

  test('addTask returns failure when local data source throws', () async {
    when(
      () => dataSource.addTask(any()),
    ).thenThrow(const CacheException('Could not save task.'));

    final result = await repository.addTask(task);

    expect(result.isSuccess, false);
    expect(result.failure?.message, 'Could not save task.');
  });

  test('deleteTask returns success for valid operation', () async {
    when(() => dataSource.deleteTask('id-1')).thenAnswer((_) async {});

    final result = await repository.deleteTask('id-1');

    expect(result.isSuccess, true);
    verify(() => dataSource.deleteTask('id-1')).called(1);
  });
}
