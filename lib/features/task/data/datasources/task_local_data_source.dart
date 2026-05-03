import 'package:hive/hive.dart';
import 'package:smart_task_manager/core/error/exceptions.dart';
import 'package:smart_task_manager/features/task/data/models/task_model.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> getTasks();
  Future<void> addTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(String id);
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  TaskLocalDataSourceImpl(this.taskBox);
  final Box<TaskModel> taskBox;

  @override
  Future<List<TaskModel>> getTasks() async {
    try {
      final tasks = taskBox.values.toList();
      tasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return tasks;
    } catch (_) {
      throw const CacheException('Could not fetch tasks.');
    }
  }

  @override
  Future<void> addTask(TaskModel task) async {
    try {
      await taskBox.put(task.id, task);
    } catch (_) {
      throw const CacheException('Could not save task.');
    }
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    try {
      await taskBox.put(task.id, task);
    } catch (_) {
      throw const CacheException('Could not update task.');
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    try {
      await taskBox.delete(id);
    } catch (_) {
      throw const CacheException('Could not delete task.');
    }
  }
}
