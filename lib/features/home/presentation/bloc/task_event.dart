import 'package:equatable/equatable.dart';
import 'package:task_tracker_app/features/home/domain/entities/task_entity.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class GetAllTasksEvent extends TaskEvent {
  final String userId;

  const GetAllTasksEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class CreateTaskEvent extends TaskEvent {
  final TaskEntity taskEntity;

  const CreateTaskEvent({required this.taskEntity});

  @override
  List<Object> get props => [taskEntity];
}

class DeleteTaskEvent extends TaskEvent {
  final String taskId;

  const DeleteTaskEvent({required this.taskId});
  @override
  List<Object> get props => [taskId];
}

class EditTaskEvent extends TaskEvent {
  final TaskEntity taskEntity;

  const EditTaskEvent({required this.taskEntity});
}
