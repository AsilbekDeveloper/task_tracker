import 'package:task_tracker_app/features/home/domain/entities/task_entity.dart';
import 'package:task_tracker_app/features/home/domain/repositories/task_repository.dart';

class CreateTaskUseCase {
  final TaskRepository _taskRepository;

  CreateTaskUseCase(this._taskRepository);

  Future<TaskEntity> call({required TaskEntity taskEntity}) {
    return _taskRepository.createTask(taskEntity: taskEntity);
  }
}
