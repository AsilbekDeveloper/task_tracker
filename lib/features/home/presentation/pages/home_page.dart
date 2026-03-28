import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:task_tracker_app/core/app_images_icons/app_images.dart';
import 'package:task_tracker_app/core/app_text_styles.dart';
import 'package:task_tracker_app/core/router/route_names.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/category_list/category_list_bloc.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/category_list/category_list_event.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/category_list/category_list_state.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/create_task/create_task_bloc.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/create_task/create_task_state.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/get_all_tasks/get_all_tasks_bloc.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/get_all_tasks/get_all_tasks_event.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/get_all_tasks/get_all_tasks_state.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/update_task/update_task_bloc.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/update_task/update_task_event.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/update_task/update_task_state.dart';
import 'package:task_tracker_app/features/home/presentation/widget/task_widget.dart';
import 'package:task_tracker_app/features/categories/domain/entities/category_entity.dart';
import 'package:task_tracker_app/generated/strings.g.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      context.read<GetAllTasksBloc>().add(GetAllTasksEvent(userId: user.uid));
      context.read<CategoryListBloc>().add(LoadCategories());
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return DefaultTabController(
      length: 2,
      child: MultiBlocListener(
        listeners: [
          BlocListener<CreateTaskBloc, CreateTaskState>(
            listener: (context, state) {
              if (state is CreateTaskSuccess) _loadData();
            },
          ),
          BlocListener<UpdateTaskBloc, UpdateTaskState>(
            listener: (context, state) {
              if (state is UpdateTaskSuccess) {
                _loadData();
              } else if (state is UpdateTaskError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: colorScheme.error,
                  ),
                );
              }
            },
          ),
        ],
        child: Scaffold(
          backgroundColor: colorScheme.surface,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: AppBar(
                backgroundColor: colorScheme.surface,
                elevation: 0,
                centerTitle: true,
                title: Text(
                  t.home.tasksList,
                  style: AppTextStyles.headlineMedium.copyWith(color: colorScheme.onSurface),
                ),
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabBar(
                  indicatorColor: colorScheme.primary,
                  indicatorWeight: 3,
                  labelColor: colorScheme.onSurface,
                  unselectedLabelColor: colorScheme.onSurface.withOpacity(
                    0.5,
                  ),
                  labelStyle: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  tabs: [
                    Tab(text: t.home.incomplete),
                    Tab(text: t.home.completed),
                  ],
                ),
                SizedBox(height: 16.h),
                Expanded(
                  child: TabBarView(
                    children: [
                      _TaskListView(isCompleted: false),
                      _TaskListView(isCompleted: true),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TaskListView extends StatelessWidget {
  final bool isCompleted;

  const _TaskListView({required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final theme = Theme.of(context);

    return BlocBuilder<CategoryListBloc, CategoryListState>(
      builder: (context, categoryState) {
        if (categoryState is CategoryListLoading) {
          return Center(
            child: CircularProgressIndicator(color: theme.colorScheme.primary),
          );
        }
        if (categoryState is CategoryListError) {
          return Center(
            child: Text(
              t.category.categoryLoadFailed,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
          );
        }
        if (categoryState is CategoryListSuccess) {
          final categories = categoryState.categoryList.categoryList;

          return BlocBuilder<GetAllTasksBloc, GetAllTasksState>(
            builder: (context, taskState) {
              if (taskState is GetAllTasksLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: theme.colorScheme.primary,
                  ),
                );
              }
              if (taskState is GetAllTasksError) {
                return Center(
                  child: Text(
                    taskState.errorMessage,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                );
              }
              if (taskState is GetAllTasksSuccess) {
                final filteredTasks =
                    taskState.tasks.allTasks
                        .where((task) => task.isCompleted == isCompleted)
                        .toList();

                if (filteredTasks.isEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(height: 100.h),
                        Image.asset(AppImages.checklist),
                        SizedBox(height: 16.h),
                        Text(
                          textAlign: TextAlign.center,
                          t.home.whatWant,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          t.home.addTasks,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: filteredTasks.length,
                  separatorBuilder: (_, __) => SizedBox(height: 16.h),
                  itemBuilder: (context, index) {
                    final task = filteredTasks[index];

                    CategoryEntity taskCategory;
                    try {
                      taskCategory = categories.firstWhere(
                        (cat) => cat.categoryId == task.categoryId,
                      );
                    } catch (e) {
                      taskCategory = CategoryEntity(
                        categoryId: t.task.unknown,
                        categoryName: t.task.unknown,
                        userId: '',
                        color: 0xFF9E9E9E,
                        iconCode: 0xe3af,
                      );
                    }
                    return TaskWidget(
                      title: task.title,
                      dateTime: task.dateTime,
                      categoryName: taskCategory.categoryName,
                      categoryColor: Color(taskCategory.color),
                      icon: IconData(
                        taskCategory.iconCode,
                        fontFamily: 'MaterialIcons',
                      ),
                      priority: task.priority.toString(),
                      value: task.isCompleted,
                      onChanged: (value) {
                        if (value != null) {
                          context.read<UpdateTaskBloc>().add(
                            UpdateTaskStatusEvent(
                              taskId: task.taskId,
                              isCompleted: value,
                            ),
                          );
                        }
                      },
                      onPressed: () {
                        context.pushNamed(
                          RouteNames.singleTask,
                          pathParameters: {'id': task.taskId},
                          extra: {"task": task, "category": taskCategory},
                        );
                      },
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
