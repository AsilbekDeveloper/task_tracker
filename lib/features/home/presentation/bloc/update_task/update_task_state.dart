import 'package:equatable/equatable.dart';

abstract class UpdateTaskState extends Equatable {
  const UpdateTaskState();

  @override
  List<Object?> get props => [];
}

class UpdateTaskInitial extends UpdateTaskState {}

class UpdateTaskLoading extends UpdateTaskState {}

class UpdateTaskSuccess extends UpdateTaskState {
  final String taskId;

  const UpdateTaskSuccess(this.taskId);

  @override
  List<Object?> get props => [taskId];
}

class UpdateTaskError extends UpdateTaskState {
  final String message;

  const UpdateTaskError(this.message);

  @override
  List<Object?> get props => [message];
}