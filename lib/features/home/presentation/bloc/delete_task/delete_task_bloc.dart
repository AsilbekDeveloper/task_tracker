import 'package:bloc/bloc.dart';
import 'package:task_tracker_app/features/home/domain/use_cases/delete_task_use_case.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/delete_task/delete_task_state.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/task_event.dart';

class DeleteTaskBloc extends Bloc<TaskEvent, DeleteTaskState> {
  final DeleteTaskUseCase deleteTaskUseCase;

  DeleteTaskBloc({required this.deleteTaskUseCase}) : super(DeleteTaskInitial()) {
    on<DeleteTaskEvent>((event, emit) async {
      emit(DeleteTaskLoading());
      try {
        await deleteTaskUseCase(taskId: event.taskId);
        emit(DeleteTaskSuccess(event.taskId));
      } catch (e) {
        emit(DeleteTaskError("Server xatosi: ${e.toString()}"));
      }
    });
  }
}