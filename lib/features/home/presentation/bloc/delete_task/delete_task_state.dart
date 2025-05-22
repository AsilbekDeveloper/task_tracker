import 'package:equatable/equatable.dart';
import 'package:task_tracker_app/features/home/domain/entities/task_entity.dart';

abstract class DeleteTaskState extends Equatable {
  const DeleteTaskState();

  @override
  List<Object?> get props => [];
}

class DeleteTaskInitial extends DeleteTaskState {}

class DeleteTaskLoading extends DeleteTaskState {}

class DeleteTaskSuccess extends DeleteTaskState {
  final String taskId;

  const DeleteTaskSuccess(this.taskId);

  @override
  List<Object?> get props => [taskId];
}

class DeleteTaskError extends DeleteTaskState {
  final String errorMessage;

  const DeleteTaskError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}