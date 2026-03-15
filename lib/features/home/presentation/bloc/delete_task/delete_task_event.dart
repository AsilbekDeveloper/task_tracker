import 'package:task_tracker_app/features/home/presentation/bloc/task_event.dart';

class DeleteTaskEvent extends TaskEvent {
  final String taskId;

  const DeleteTaskEvent({required this.taskId});
  @override
  List<Object> get props => [taskId];
}