import 'package:task_tracker_app/features/home/domain/repositories/task_repository.dart';

class DeleteTaskUseCase {
  final TaskRepository _taskRepository;

  DeleteTaskUseCase(this._taskRepository);

  Future<void> call({required String taskId}) {
    return _taskRepository.deleteTask(taskId: taskId);
  }
}
