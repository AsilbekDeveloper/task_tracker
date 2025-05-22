import 'package:equatable/equatable.dart';
import 'package:task_tracker_app/features/home/domain/entities/task_list_entity.dart';

abstract class GetAllTasksState extends Equatable {
  const GetAllTasksState();

  @override
  List<Object?> get props => [];
}

class GetAllTasksInitial extends GetAllTasksState {}

class GetAllTasksLoading extends GetAllTasksState {}

class GetAllTasksSuccess extends GetAllTasksState {
  final TaskListEntity tasks;

  const GetAllTasksSuccess(this.tasks);

  @override
  List<Object?> get props => [tasks];
}

class GetAllTasksError extends GetAllTasksState {
  final String errorMessage;

  const GetAllTasksError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}