import 'package:equatable/equatable.dart';

abstract class UpdateTaskEvent extends Equatable {
  const UpdateTaskEvent();

  @override
  List<Object?> get props => [];
}

class UpdateTaskStatusEvent extends UpdateTaskEvent {
  final String taskId;
  final bool isCompleted;

  const UpdateTaskStatusEvent({
    required this.taskId,
    required this.isCompleted,
  });

  @override
  List<Object?> get props => [taskId, isCompleted];
}