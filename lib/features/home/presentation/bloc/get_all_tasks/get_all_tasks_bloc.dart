import 'package:bloc/bloc.dart';
import 'package:task_tracker_app/features/home/domain/use_cases/get_all_tasks_use_case.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/get_all_tasks/get_all_tasks_state.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/task_event.dart';

class GetAllTasksBloc extends Bloc<TaskEvent, GetAllTasksState> {
  final GetAllTasksUseCase getAllTasksUseCase;

  GetAllTasksBloc({required this.getAllTasksUseCase}) : super(GetAllTasksInitial()) {
    on<GetAllTasksEvent>((event, emit) async {
      emit(GetAllTasksLoading());
      try {
        final tasks = await getAllTasksUseCase(
          userId: event.userId
        );
        emit(GetAllTasksSuccess(tasks));
      } catch (e) {
        emit(GetAllTasksError("Server xatosi: ${e.toString()}"));
      }
    });
  }
}