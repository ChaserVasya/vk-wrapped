import 'package:equatable/equatable.dart';
import 'package:project_utils/src/exception/app_exception.dart';

enum TaskProgressStatus { idle, progress, success, error }

extension TaskPreggressStatusExtensions on TaskProgressStatus {
  bool get isSuccess => this == TaskProgressStatus.success;
  bool get isProgress => this == TaskProgressStatus.progress;
  bool get isIdle => this == TaskProgressStatus.idle;
  bool get isError => this == TaskProgressStatus.error;
}

class TaskProgress extends Equatable {
  const TaskProgress(this.status, {this.exception});

  const TaskProgress.pure() : this(TaskProgressStatus.idle);

  const TaskProgress.progress() : this(TaskProgressStatus.progress);

  const TaskProgress.success() : this(TaskProgressStatus.success);

  const TaskProgress.error(AppException? exception)
      : this(TaskProgressStatus.error, exception: exception);

  final TaskProgressStatus status;
  final AppException? exception;

  @override
  List<Object?> get props => [status, exception];
}
