import 'package:bloc/bloc.dart';
import 'package:task_tracker_app/features/home/domain/entities/task_list_entity.dart';
import 'package:task_tracker_app/features/home/domain/use_cases/get_all_tasks_use_case.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/get_all_tasks/get_all_tasks_event.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/get_all_tasks/get_all_tasks_state.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/task_event.dart';

class GetAllTasksBloc extends Bloc<TaskEvent, GetAllTasksState> {
  final GetAllTasksUseCase getAllTasksUseCase;

  GetAllTasksBloc({required this.getAllTasksUseCase})
      : super(GetAllTasksInitial()) {
    on<GetAllTasksEvent>(_onGetAllTasks);
  }

  Future<void> _onGetAllTasks(
      GetAllTasksEvent event,
      Emitter<GetAllTasksState> emit,
      ) async {

    emit(GetAllTasksLoading());

    try {
      final taskListEntity = await getAllTasksUseCase(userId: event.userId);

      final sortedTasks = List.of(taskListEntity.allTasks)
        ..sort((a, b) => a.priority.compareTo(b.priority));

      final sortedTaskListEntity = TaskListEntity(allTasks: sortedTasks);

      emit(GetAllTasksSuccess(sortedTaskListEntity));

    } catch (e) {
      emit(GetAllTasksError("Server error: ${e.toString()}"));
    }
  }
}