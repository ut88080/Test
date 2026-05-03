import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_task_manager/core/services/di/injection_container.dart';
import 'package:smart_task_manager/features/task/presentation/viewmodels/task_state.dart';
import 'package:smart_task_manager/features/task/presentation/viewmodels/task_view_model.dart';

final taskViewModelProvider = StateNotifierProvider<TaskViewModel, TaskState>((
  ref,
) {
  return TaskViewModel(
    getTasks: sl(),
    addTask: sl(),
    updateTask: sl(),
    deleteTask: sl(),
  )..loadTasks();
});
