import 'package:task_tracker_app/features/home/domain/entities/task_entity.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/task_event.dart';

class EditTaskEvent extends TaskEvent {
  final TaskEntity taskEntity;

  const EditTaskEvent({required this.taskEntity});
}
