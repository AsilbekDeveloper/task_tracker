import 'package:equatable/equatable.dart';
import 'package:task_tracker_app/features/home/domain/entities/task_entity.dart';

abstract class CreateTaskState extends Equatable {
  const CreateTaskState();

  @override
  List<Object?> get props => [];
}

class CreateTaskInitial extends CreateTaskState {}

class CreateTaskLoading extends CreateTaskState {}

class CreateTaskSuccess extends CreateTaskState {
  final TaskEntity newTask;

  const CreateTaskSuccess(this.newTask);

  @override
  List<Object?> get props => [newTask];
}

/// ✅ New state for validation errors
class CreateTaskValidationError extends CreateTaskState {
  final String errorMessage;

  const CreateTaskValidationError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

/// ✅ State for server/firebase errors
class CreateTaskError extends CreateTaskState {
  final String errorMessage;

  const CreateTaskError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}