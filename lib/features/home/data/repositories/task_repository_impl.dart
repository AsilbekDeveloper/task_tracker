import 'package:task_tracker_app/features/home/data/data_source/task_remote_data_source.dart';
import 'package:task_tracker_app/features/home/domain/entities/task_entity.dart';
import 'package:task_tracker_app/features/home/domain/entities/task_list_entity.dart';
import 'package:task_tracker_app/features/home/domain/repositories/task_repository.dart';

class TaskRepositoryImpl extends TaskRepository {
  final TaskRemoteDataSource taskRemoteDataSource;

  TaskRepositoryImpl(this.taskRemoteDataSource);

  @override
  Future<TaskEntity> createTask({required TaskEntity taskEntity}) {
    return taskRemoteDataSource.createTask(taskEntity: taskEntity);
  }

  @override
  Future<TaskListEntity> getAllTasks({required String userId}) {
    return taskRemoteDataSource.getAllTasks(userId: userId);
  }

  @override
  Future<void> deleteTask({required String taskId}) {
    return taskRemoteDataSource.deleteTask(taskId: taskId);
  }

  @override
  Future<TaskEntity> editTask({required TaskEntity taskEntity}) {
    return taskRemoteDataSource.editTask(taskEntity: taskEntity);
  }

}