import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tracker_app/features/home/domain/use_cases/update_task_status_use_case.dart';
import 'package:task_tracker_app/generated/strings.g.dart';
import 'update_task_event.dart';
import 'update_task_state.dart';

class UpdateTaskBloc extends Bloc<UpdateTaskEvent, UpdateTaskState> {
  final UpdateTaskStatusUseCase updateTaskStatusUseCase;

  UpdateTaskBloc({required this.updateTaskStatusUseCase})
      : super(UpdateTaskInitial()) {
    on<UpdateTaskStatusEvent>(_onUpdateStatus);
  }

  Future<void> _onUpdateStatus(
      UpdateTaskStatusEvent event,
      Emitter<UpdateTaskState> emit,
      ) async {
    emit(UpdateTaskLoading());

    try {
      await updateTaskStatusUseCase(
        taskId: event.taskId,
        isCompleted: event.isCompleted,
      );

      emit(UpdateTaskSuccess(event.taskId));

    } catch (e) {
      emit(UpdateTaskError('${t.errors.failedToUpdateTask} ${e.toString()}'));
    }
  }
}