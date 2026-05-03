import 'package:smart_task_manager/features/task/domain/entities/task.dart';

class TaskState {
  const TaskState({
    this.tasks = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  final List<Task> tasks;
  final bool isLoading;
  final String? errorMessage;

  bool get isEmpty => tasks.isEmpty;

  TaskState copyWith({
    List<Task>? tasks,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
