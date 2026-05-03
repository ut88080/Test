import 'package:smart_task_manager/core/error/failures.dart';
import 'package:smart_task_manager/core/usecases/usecase.dart';
import 'package:smart_task_manager/core/utils/result.dart';
import 'package:smart_task_manager/features/task/domain/entities/task.dart';
import 'package:smart_task_manager/features/task/domain/repositories/task_repository.dart';

class AddTask implements UseCase<Result<void>, Task> {
  AddTask(this.repository);
  final TaskRepository repository;

  @override
  Future<Result<void>> call(Task params) {
    if (params.title.trim().isEmpty) {
      return Future.value(
        Result.error(const ValidationFailure('Title is required.')),
      );
    }
    return repository.addTask(params);
  }
}
