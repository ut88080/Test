import 'package:smart_task_manager/core/error/exceptions.dart';
import 'package:smart_task_manager/core/error/failures.dart';
import 'package:smart_task_manager/core/utils/result.dart';
import 'package:smart_task_manager/features/task/data/datasources/task_local_data_source.dart';
import 'package:smart_task_manager/features/task/data/models/task_model.dart';
import 'package:smart_task_manager/features/task/domain/entities/task.dart';
import 'package:smart_task_manager/features/task/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  TaskRepositoryImpl({required this.localDataSource});

  final TaskLocalDataSource localDataSource;

  @override
  Future<Result<List<Task>>> getTasks() async {
    try {
      final models = await localDataSource.getTasks();
      return Result.success(models.map((task) => task.toEntity()).toList());
    } on CacheException catch (e) {
      return Result.error(CacheFailure(e.message));
    } catch (_) {
      return Result.error(const UnknownFailure());
    }
  }

  @override
  Future<Result<void>> addTask(Task task) async {
    try {
      await localDataSource.addTask(TaskModel.fromEntity(task));
      return Result.success(null);
    } on CacheException catch (e) {
      return Result.error(CacheFailure(e.message));
    } catch (_) {
      return Result.error(const UnknownFailure());
    }
  }

  @override
  Future<Result<void>> updateTask(Task task) async {
    try {
      await localDataSource.updateTask(TaskModel.fromEntity(task));
      return Result.success(null);
    } on CacheException catch (e) {
      return Result.error(CacheFailure(e.message));
    } catch (_) {
      return Result.error(const UnknownFailure());
    }
  }

  @override
  Future<Result<void>> deleteTask(String id) async {
    try {
      await localDataSource.deleteTask(id);
      return Result.success(null);
    } on CacheException catch (e) {
      return Result.error(CacheFailure(e.message));
    } catch (_) {
      return Result.error(const UnknownFailure());
    }
  }
}
