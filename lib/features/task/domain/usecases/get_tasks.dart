import 'package:smart_task_manager/core/usecases/usecase.dart';
import 'package:smart_task_manager/core/utils/result.dart';
import 'package:smart_task_manager/features/task/domain/entities/task.dart';
import 'package:smart_task_manager/features/task/domain/repositories/task_repository.dart';

class GetTasks implements UseCase<Result<List<Task>>, NoParams> {
  GetTasks(this.repository);
  final TaskRepository repository;

  @override
  Future<Result<List<Task>>> call(NoParams params) => repository.getTasks();
}
