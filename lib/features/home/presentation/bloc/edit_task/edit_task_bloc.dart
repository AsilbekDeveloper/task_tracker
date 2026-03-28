import 'package:bloc/bloc.dart';
import 'package:task_tracker_app/features/home/domain/use_cases/edit_task_use_case.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/edit_task/edit_task_event.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/edit_task/edit_task_state.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/task_event.dart';
import 'package:task_tracker_app/generated/strings.g.dart';

class EditTaskBloc extends Bloc<TaskEvent, EditTaskState> {
  final EditTaskUseCase editTaskUseCase;

  EditTaskBloc({required this.editTaskUseCase}) : super(EditTaskInitial()) {
    on<EditTaskEvent>(_onEditTask);
  }

  Future<void> _onEditTask(
    EditTaskEvent event,
    Emitter<EditTaskState> emit,
  ) async {
    emit(EditTaskLoading());

    try {
      final editedTask = await editTaskUseCase(taskEntity: event.taskEntity);
      emit(EditTaskSuccess(editedTask));
    } catch (e) {
      if (e.toString().contains("VALIDATION_ERROR")) {
        emit(EditTaskValidationError(t.task.fillRequiredFields));
      } else {
        emit(EditTaskError("${t.errors.serverError} ${e.toString()}"));
      }
    }
  }
}
