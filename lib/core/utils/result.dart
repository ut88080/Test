import 'package:smart_task_manager/core/error/failures.dart';

class Result<T> {
  const Result._({this.data, this.failure});

  factory Result.success(T data) => Result._(data: data);

  factory Result.error(Failure failure) => Result._(failure: failure);

  final T? data;
  final Failure? failure;

  bool get isSuccess => failure == null;
}
