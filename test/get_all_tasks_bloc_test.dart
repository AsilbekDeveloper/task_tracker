import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_tracker_app/features/home/domain/entities/task_entity.dart';
import 'package:task_tracker_app/features/home/domain/entities/task_list_entity.dart';
import 'package:task_tracker_app/features/home/domain/use_cases/get_all_tasks_use_case.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/get_all_tasks/get_all_tasks_bloc.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/get_all_tasks/get_all_tasks_state.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/task_event.dart';

import 'mocks/mock_task_repository.dart';


void main() {
  late GetAllTasksBloc getAllTasksBloc;
  late MockTaskRepository mockTaskRepository;
  late GetAllTasksUseCase getAllTasksUseCase;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    getAllTasksUseCase = GetAllTasksUseCase(mockTaskRepository);
    getAllTasksBloc = GetAllTasksBloc(getAllTasksUseCase: getAllTasksUseCase);
  });

  tearDown(() {
    getAllTasksBloc.close();
  });

  const testUserId = 'user123';

  final testTasks = TaskListEntity(allTasks: [
    TaskEntity(
      taskId: '1',
      title: 'Test Task',
      description: 'Testing',
      categoryId: 'cat1',
      isCompleted: false,
      priority: 1,
      dateTime: DateTime(2024, 10, 10),
      endTime: DateTime(2024, 10, 11),
      userId: testUserId,
    ),
  ]);

  blocTest<GetAllTasksBloc, GetAllTasksState>(
    'emits [Loading, Success] when use case returns tasks successfully',
    build: () {
      when(() => mockTaskRepository.getAllTasks(userId: testUserId))
          .thenAnswer((_) async => testTasks);
      return getAllTasksBloc;
    },
    act: (bloc) => bloc.add(const GetAllTasksEvent(userId: testUserId)),
    expect: () => [
      GetAllTasksLoading(),
      GetAllTasksSuccess(testTasks),
    ],
  );

  blocTest<GetAllTasksBloc, GetAllTasksState>(
    'emits [Loading, Error] when use case throws an error',
    build: () {
      when(() => mockTaskRepository.getAllTasks(userId: testUserId))
          .thenThrow(Exception('Failed to fetch'));
      return getAllTasksBloc;
    },
    act: (bloc) => bloc.add(const GetAllTasksEvent(userId: testUserId)),
    expect: () => [
      GetAllTasksLoading(),
      isA<GetAllTasksError>(),
    ],
  );
}
