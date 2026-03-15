import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:task_tracker_app/core/app_text_styles.dart';
import 'package:task_tracker_app/core/router/route_names.dart';
import 'package:task_tracker_app/features/categories/data/models/category_model.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/category_list/category_list_bloc.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/category_list/category_list_event.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/category_list/category_list_state.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/delete_category/delete_category_bloc.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/delete_category/delete_category_event.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/delete_task/delete_task_bloc.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/delete_task/delete_task_event.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/get_all_tasks/get_all_tasks_bloc.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/get_all_tasks/get_all_tasks_event.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/get_all_tasks/get_all_tasks_state.dart';
import 'package:task_tracker_app/features/home/presentation/widget/task_widget.dart';
import 'package:task_tracker_app/generated/strings.g.dart';

class SingleCategoryPage extends StatefulWidget {
  final String categoryName;
  final String categoryId;

  const SingleCategoryPage({
    super.key,
    required this.categoryName,
    required this.categoryId,
  });

  @override
  State<SingleCategoryPage> createState() => _SingleCategoryPageState();
}

class _SingleCategoryPageState extends State<SingleCategoryPage> {
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
        title: Text(
          widget.categoryName,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              IconsaxPlusLinear.trash,
              color: theme.colorScheme.onSurface,
            ),
            onPressed: () {
              final categoryState = context.read<CategoryListBloc>().state;
              final taskState = context.read<GetAllTasksBloc>().state;

              if (categoryState is CategoryListSuccess &&
                  taskState is GetAllTasksSuccess) {
                final categoryList = categoryState.categoryList.categoryList;

                final selectedCategory = categoryList.firstWhere(
                  (cat) => cat.categoryId == widget.categoryId,
                  orElse:
                      () => CategoryModel(
                        categoryId: '',
                        categoryName: '',
                        iconCode: 0,
                        color: 0,
                        userId: '',
                      ),
                );

                if (selectedCategory.categoryId.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(t.category.categoryNotFound)),
                  );
                  return;
                }

                final relatedTasks =
                    taskState.tasks.allTasks
                        .where(
                          (task) =>
                              task.categoryId == selectedCategory.categoryId,
                        )
                        .toList();

                if (relatedTasks.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(t.category.tasksExistInCategory)),
                  );
                  return;
                }

                context.read<DeleteCategoryBloc>().add(
                  DeleteCategory(categoryId: selectedCategory.categoryId),
                );

                context.read<CategoryListBloc>().add(LoadCategories());
                context.pop();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: BlocBuilder<CategoryListBloc, CategoryListState>(
          builder: (context, categoryState) {
            if (categoryState is CategoryListSuccess) {
              final categoryList = categoryState.categoryList.categoryList;

              final selectedCategory = categoryList.firstWhere(
                (cat) => cat.categoryId == widget.categoryId,
                orElse:
                    () => CategoryModel(
                      categoryId: '',
                      categoryName: '',
                      iconCode: 0,
                      color: 0,
                      userId: '',
                    ),
              );

              if (selectedCategory.categoryId.isEmpty) {
                return Center(
                  child: Text(
                    t.category.categoryNotFound,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                );
              }

              return BlocBuilder<GetAllTasksBloc, GetAllTasksState>(
                builder: (context, taskState) {
                  if (taskState is GetAllTasksSuccess) {
                    final taskList =
                        taskState.tasks.allTasks
                            .where(
                              (task) =>
                                  task.categoryId ==
                                  selectedCategory.categoryId,
                            )
                            .toList();

                    taskList.sort((a, b) => a.priority.compareTo(b.priority));

                    if (taskList.isEmpty) {
                      return Center(
                        child: Text(
                          t.home.tasksNotDownloaded,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      itemCount: taskList.length,
                      separatorBuilder: (_, __) => SizedBox(height: 16.h),
                      itemBuilder: (context, index) {
                        final task = taskList[index];
                        return TaskWidget(
                          title: task.title,
                          dateTime: task.dateTime,
                          categoryName: selectedCategory.categoryName,
                          categoryColor: Color(selectedCategory.color),
                          icon: IconData(selectedCategory.iconCode),
                          priority: task.priority.toString(),
                          value: task.isCompleted,
                          onChanged: (val) {
                            context.read<DeleteTaskBloc>().add(
                              DeleteTaskEvent(taskId: task.taskId),
                            );
                            final userId =
                                FirebaseAuth.instance.currentUser?.uid;
                            if (userId != null) {
                              context.read<GetAllTasksBloc>().add(
                                GetAllTasksEvent(userId: userId),
                              );
                            }
                          },
                          onPressed: () {
                            context.pushNamed(
                              RouteNames.singleTask,
                              pathParameters: {'id': task.taskId},
                              extra: {
                                'task': task,
                                'category': selectedCategory,
                              },
                            );
                          },
                        );
                      },
                    );
                  } else if (taskState is GetAllTasksLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: theme.colorScheme.primary,
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        t.home.errorLoadingTasks,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    );
                  }
                },
              );
            } else if (categoryState is CategoryListLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: theme.colorScheme.primary,
                ),
              );
            } else {
              return Center(
                child: Text(
                  t.category.categoryLoadFailed,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
