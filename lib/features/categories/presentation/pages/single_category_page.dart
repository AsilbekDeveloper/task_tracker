import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:task_tracker_app/core/app_text_styles.dart';
import 'package:task_tracker_app/core/colors/app_colors.dart';
import 'package:task_tracker_app/core/routes/route_names.dart';
import 'package:task_tracker_app/core/utils/responsive_helper.dart';
import 'package:task_tracker_app/features/categories/data/models/category_model.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/category_list/category_list_bloc.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/category_list/category_list_state.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/delete_task/delete_task_bloc.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/get_all_tasks/get_all_tasks_bloc.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/get_all_tasks/get_all_tasks_state.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/task_event.dart';
import 'package:task_tracker_app/features/home/presentation/widget/task_widget.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/delete_category/delete_category_bloc.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/categories_event.dart';

class SingleCategoryPage extends StatefulWidget {
  final String categoryName;

  const SingleCategoryPage({
    super.key,
    required this.categoryName,
    required String categoryId,
  });

  @override
  State<SingleCategoryPage> createState() => _SingleCategoryPageState();
}

class _SingleCategoryPageState extends State<SingleCategoryPage> {
  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        iconTheme: IconThemeData(color: AppColors.whiteColor),
        title: Text(widget.categoryName, style: AppTextStyles.normal20),
        actions: [
          IconButton(
            icon: const Icon(IconsaxPlusLinear.trash),
            onPressed: () {
              final categoryState = context.read<CategoryListBloc>().state;
              final taskState = context.read<GetAllTasksBloc>().state;

              if (categoryState is CategoryListSuccess &&
                  taskState is GetAllTasksSuccess) {
                final selectedCategory = categoryState.categoryList.categories.firstWhere(
                      (cat) => cat.categoryName == widget.categoryName,
                  orElse: () => CategoryModel(
                    categoryId: '',
                    categoryName: '',
                    iconCode: 0,
                    color: 0,
                    userId: '',
                    fontFamily: '',
                  ),
                );

                if (selectedCategory.categoryId.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Kategoriya topilmadi")),
                  );
                  return;
                }

                final relatedTasks = taskState.tasks.allTasks.where(
                      (task) => task.categoryId == selectedCategory.categoryId,
                );

                if (relatedTasks.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Bu kategoriyada topshiriqlar mavjud!")),
                  );
                  return;
                }

                context.read<DeleteCategoryBloc>().add(
                  DeleteCategoryEvent(categoryId: selectedCategory.categoryId),
                );
                final userId = FirebaseAuth.instance.currentUser!.uid;
                context.read<CategoryListBloc>().add(CategoryListEvent(userId: userId));
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.wPixel(24)),
        child: BlocBuilder<CategoryListBloc, CategoryListState>(
          builder: (context, categoryState) {
            if (categoryState is CategoryListSuccess) {
              final categoryList = categoryState.categoryList.categories;

              final selectedCategory = categoryList.firstWhere(
                    (cat) => cat.categoryName == widget.categoryName,
                orElse: () => CategoryModel(
                  categoryId: '',
                  categoryName: '',
                  iconCode: 0,
                  color: 0,
                  userId: '',
                  fontFamily: '',
                ),
              );

              if (selectedCategory.categoryId.isEmpty) {
                return const Center(child: Text("Kategoriya topilmadi"));
              }

              return BlocBuilder<GetAllTasksBloc, GetAllTasksState>(
                builder: (context, taskState) {
                  if (taskState is GetAllTasksSuccess) {
                    final taskList = taskState.tasks.allTasks
                        .where((task) => task.categoryId == selectedCategory.categoryId)
                        .toList();

                    taskList.sort((a, b) => a.priority.compareTo(b.priority));

                    if (taskList.isEmpty) {
                      return Center(
                        child: Text("No tasks available", style: AppTextStyles.medium20),
                      );
                    }

                    return ListView.separated(
                      itemCount: taskList.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final task = taskList[index];
                        return TaskWidget(
                          title: task.title,
                          dateTime: task.dateTime,
                          categoryName: selectedCategory.categoryName,
                          categoryColor: Color(selectedCategory.color),
                          icon: IconData(
                            selectedCategory.iconCode,
                            fontFamily: selectedCategory.fontFamily ?? 'MaterialIcons',
                          ),
                          priority: task.priority.toString(),
                          value: task.isCompleted,
                          onChanged: (val) {
                            context.read<DeleteTaskBloc>().add(DeleteTaskEvent(taskId: task.taskId));
                            final userId = FirebaseAuth.instance.currentUser!.uid;
                            context.read<GetAllTasksBloc>().add(GetAllTasksEvent(userId: userId));
                          },
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              RouteNames.singleTaskPage,
                              arguments: {
                                'task': task,
                                'category': selectedCategory,
                              },
                            );
                          },
                        );
                      },
                    );
                  } else if (taskState is GetAllTasksLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const Center(child: Text("Xatolik yuz berdi"));
                  }
                },
              );
            } else if (categoryState is CategoryListLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(child: Text("Kategoriyalar yuklanmadi"));
            }
          },
        ),
      ),
    );
  }
}
