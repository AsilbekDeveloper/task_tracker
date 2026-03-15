import 'package:task_tracker_app/features/home/presentation/bloc/task_event.dart';

class GetAllTasksEvent extends TaskEvent {
  final String userId;

  const GetAllTasksEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}