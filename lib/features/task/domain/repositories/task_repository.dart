import 'package:smart_task_manager/core/utils/result.dart';
import 'package:smart_task_manager/features/task/domain/entities/task.dart';

abstract class TaskRepository {
  Future<Result<List<Task>>> getTasks();
  Future<Result<void>> addTask(Task task);
  Future<Result<void>> updateTask(Task task);
  Future<Result<void>> deleteTask(String id);
}
