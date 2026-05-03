import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_task_manager/features/task/domain/entities/task.dart';
import 'package:smart_task_manager/features/task/presentation/providers/task_providers.dart';
import 'package:smart_task_manager/features/task/presentation/screens/add_edit_task_screen.dart';

class TaskListScreen extends ConsumerWidget {
  const TaskListScreen({super.key});

  Future<void> _openTaskForm(BuildContext context, {Task? task}) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => AddEditTaskScreen(task: task)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(taskViewModelProvider);
    final notifier = ref.read(taskViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Smart Task Manager')),
      body: RefreshIndicator(
        onRefresh: notifier.loadTasks,
        child: Builder(
          builder: (context) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.errorMessage != null) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.errorMessage!, textAlign: TextAlign.center),
                      const SizedBox(height: 12),
                      FilledButton(
                        onPressed: notifier.loadTasks,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state.isEmpty) {
              return const Center(
                child: Text('No tasks yet. Tap + to add one.'),
              );
            }

            return ListView.separated(
              itemCount: state.tasks.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return ListTile(
                  leading: Checkbox(
                    value: task.isCompleted,
                    onChanged: (_) => notifier.toggleTaskStatus(task),
                  ),
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  subtitle: task.description.isNotEmpty
                      ? Text(task.description)
                      : null,
                  onTap: () => _openTaskForm(context, task: task),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => notifier.deleteTask(task.id),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTaskForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
