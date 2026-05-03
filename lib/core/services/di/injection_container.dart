import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_task_manager/features/task/data/datasources/task_local_data_source.dart';
import 'package:smart_task_manager/features/task/data/models/task_model.dart';
import 'package:smart_task_manager/features/task/data/repositories/task_repository_impl.dart';
import 'package:smart_task_manager/features/task/domain/repositories/task_repository.dart';
import 'package:smart_task_manager/features/task/domain/usecases/add_task.dart';
import 'package:smart_task_manager/features/task/domain/usecases/delete_task.dart';
import 'package:smart_task_manager/features/task/domain/usecases/get_tasks.dart';
import 'package:smart_task_manager/features/task/domain/usecases/update_task.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(taskModelTypeId)) {
    Hive.registerAdapter(TaskModelAdapter());
  }
  final taskBox = await Hive.openBox<TaskModel>('tasks_box');

  sl
    ..registerLazySingleton<Box<TaskModel>>(() => taskBox)
    ..registerLazySingleton<TaskLocalDataSource>(
      () => TaskLocalDataSourceImpl(sl<Box<TaskModel>>()),
    )
    ..registerLazySingleton<TaskRepository>(
      () => TaskRepositoryImpl(localDataSource: sl<TaskLocalDataSource>()),
    )
    ..registerLazySingleton(() => GetTasks(sl<TaskRepository>()))
    ..registerLazySingleton(() => AddTask(sl<TaskRepository>()))
    ..registerLazySingleton(() => UpdateTask(sl<TaskRepository>()))
    ..registerLazySingleton(() => DeleteTask(sl<TaskRepository>()));
}
