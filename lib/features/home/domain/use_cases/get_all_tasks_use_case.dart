import 'package:task_tracker_app/features/home/domain/entities/task_list_entity.dart';
import 'package:task_tracker_app/features/home/domain/repositories/task_repository.dart';

class GetAllTasksUseCase {
  final TaskRepository _taskRepository;

  GetAllTasksUseCase(this._taskRepository);

  Future<TaskListEntity> call({required String userId}) {
    return _taskRepository.getAllTasks(userId: userId);
  }
}
