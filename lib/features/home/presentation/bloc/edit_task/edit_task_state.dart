import 'package:equatable/equatable.dart';
import 'package:task_tracker_app/features/home/domain/entities/task_entity.dart';

abstract class EditTaskState extends Equatable {
  const EditTaskState();

  @override
  List<Object?> get props => [];
}

class EditTaskInitial extends EditTaskState {}

class EditTaskLoading extends EditTaskState {}

class EditTaskSuccess extends EditTaskState {
  final TaskEntity editedTask;

  const EditTaskSuccess(this.editedTask);

  @override
  List<Object?> get props => [editedTask];
}

class EditTaskError extends EditTaskState {
  final String errorMessage;

  const EditTaskError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}