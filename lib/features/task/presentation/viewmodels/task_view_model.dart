import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_task_manager/core/usecases/usecase.dart';
import 'package:smart_task_manager/features/task/domain/entities/task.dart';
import 'package:smart_task_manager/features/task/domain/usecases/add_task.dart';
import 'package:smart_task_manager/features/task/domain/usecases/delete_task.dart';
import 'package:smart_task_manager/features/task/domain/usecases/get_tasks.dart';
import 'package:smart_task_manager/features/task/domain/usecases/update_task.dart';
import 'package:smart_task_manager/features/task/presentation/viewmodels/task_state.dart';
import 'package:uuid/uuid.dart';

class TaskViewModel extends StateNotifier<TaskState> {
  TaskViewModel({
    required GetTasks getTasks,
    required AddTask addTask,
    required UpdateTask updateTask,
    required DeleteTask deleteTask,
  }) : _getTasks = getTasks,
       _addTask = addTask,
       _updateTask = updateTask,
       _deleteTask = deleteTask,
       super(const TaskState());

  final GetTasks _getTasks;
  final AddTask _addTask;
  final UpdateTask _updateTask;
  final DeleteTask _deleteTask;
  final Uuid _uuid = const Uuid();

  Future<void> loadTasks() async {
    state = state.copyWith(isLoading: true, clearError: true);
    final result = await _getTasks(const NoParams());
    if (result.isSuccess) {
      state = state.copyWith(
        tasks: result.data!,
        isLoading: false,
        clearError: true,
      );
      return;
    }
    state = state.copyWith(
      isLoading: false,
      errorMessage: result.failure?.message,
    );
  }

  Future<void> addTask({
    required String title,
    required String description,
  }) async {
    final task = Task(
      id: _uuid.v4(),
      title: title.trim(),
      description: description.trim(),
      isCompleted: false,
      createdAt: DateTime.now(),
    );
    final result = await _addTask(task);
    if (result.isSuccess) {
      await loadTasks();
    } else {
      state = state.copyWith(errorMessage: result.failure?.message);
    }
  }

  Future<void> updateTask(Task task) async {
    final result = await _updateTask(task);
    if (result.isSuccess) {
      await loadTasks();
    } else {
      state = state.copyWith(errorMessage: result.failure?.message);
    }
  }

  Future<void> toggleTaskStatus(Task task) async {
    await updateTask(task.copyWith(isCompleted: !task.isCompleted));
  }

  Future<void> deleteTask(String id) async {
    final result = await _deleteTask(id);
    if (result.isSuccess) {
      await loadTasks();
    } else {
      state = state.copyWith(errorMessage: result.failure?.message);
    }
  }

  String generateAiTitleSuggestion(String input) {
    final raw = input.trim();
    if (raw.isEmpty) {
      return '';
    }
    // AI-assisted feature (mock logic)
    final words = raw.split(' ').where((word) => word.isNotEmpty).toList();
    final normalized = words.join(' ').toLowerCase();
    if (normalized == 'gym') {
      return 'Go to gym for 45 minutes at 7 PM';
    }
    return '${_capitalize(normalized)} - complete this by ${_nextTimeSlot()}';
  }

  String _capitalize(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1);
  }

  String _nextTimeSlot() {
    final now = DateTime.now();
    final nextHour = (now.hour + 1) % 24;
    return '${nextHour.toString().padLeft(2, '0')}:00';
  }
}
