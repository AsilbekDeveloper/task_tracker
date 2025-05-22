import 'package:task_tracker_app/features/home/domain/entities/task_entity.dart';
import 'package:task_tracker_app/features/home/domain/entities/task_list_entity.dart';

abstract class TaskRepository {
  Future<TaskListEntity> getAllTasks({required String userId});
  Future<TaskEntity> createTask({required TaskEntity taskEntity});
  Future<void> deleteTask({required String taskId});
  Future<TaskEntity> editTask({required TaskEntity taskEntity});
}
