import 'package:bloc/bloc.dart';
import 'package:task_tracker_app/features/home/domain/use_cases/create_task_use_case.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/create_task/create_task_state.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/task_event.dart';

class CreateTaskBloc extends Bloc<TaskEvent, CreateTaskState> {
  final CreateTaskUseCase createTaskUseCase;

  CreateTaskBloc({required this.createTaskUseCase}) : super(CreateTaskInitial()) {
    on<CreateTaskEvent>((event, emit) async {
      emit(CreateTaskLoading());
      try {
        final newTask = await createTaskUseCase(
          taskEntity: event.taskEntity
        );
        emit(CreateTaskSuccess(newTask));
      } catch (e) {
        emit(CreateTaskError("Server xatosi: ${e.toString()}"));
      }
    });
  }
}