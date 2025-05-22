import 'package:task_tracker_app/features/home/domain/entities/task_entity.dart';

class TaskListEntity {
  final List<TaskEntity> allTasks;

  TaskListEntity({required this.allTasks});
}