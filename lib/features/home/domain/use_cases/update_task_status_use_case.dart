import 'package:task_tracker_app/features/home/domain/entities/task_list_entity.dart';
import 'package:task_tracker_app/features/home/domain/repositories/task_repository.dart';

class UpdateTaskStatusUseCase {
  final TaskRepository taskRepository;

  UpdateTaskStatusUseCase(this.taskRepository);

  Future<void> call({required String taskId, required bool isCompleted}) {
    return taskRepository.updateTaskStatus(taskId: taskId, isCompleted: isCompleted);
  }
}
