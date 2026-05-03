import 'package:smart_task_manager/core/usecases/usecase.dart';
import 'package:smart_task_manager/core/utils/result.dart';
import 'package:smart_task_manager/features/task/domain/repositories/task_repository.dart';

class DeleteTask implements UseCase<Result<void>, String> {
  DeleteTask(this.repository);
  final TaskRepository repository;

  @override
  Future<Result<void>> call(String params) => repository.deleteTask(params);
}
