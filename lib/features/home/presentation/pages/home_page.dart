import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:task_tracker_app/core/app_images_icons/app_images.dart';
import 'package:task_tracker_app/core/app_text_styles.dart';
import 'package:task_tracker_app/core/colors/app_colors.dart';
import 'package:task_tracker_app/core/routes/route_names.dart';
import 'package:task_tracker_app/core/strings/app_string.dart';
import 'package:task_tracker_app/core/utils/responsive_helper.dart';
import 'package:task_tracker_app/features/categories/domain/entities/category_entity.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/categories_event.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/category_list/category_list_bloc.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/category_list/category_list_state.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/get_all_tasks/get_all_tasks_bloc.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/get_all_tasks/get_all_tasks_state.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/task_event.dart';
import 'package:task_tracker_app/features/home/presentation/widget/task_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      context.read<GetAllTasksBloc>().add(
        GetAllTasksEvent(userId: currentUser.uid),
      );
      context.read<CategoryListBloc>().add(
        CategoryListEvent(userId: currentUser.uid),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: AppBar(
            backgroundColor: AppColors.backgroundColor,
            elevation: 0,
            title: Text("Index", style: TextStyle(color: AppColors.whiteColor)),
            leading: IconButton(
              onPressed: () {},
              icon: Icon(IconsaxPlusLinear.sort, color: AppColors.whiteColor),
            ),
            actions: [Image.asset(AppImages.profileLogo)],
            centerTitle: true,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            Text(
              "Today’s Tasks",
              style: AppTextStyles.normal20.copyWith(
                color: AppColors.whiteColor,
              ),
            ),
            SizedBox(height: 24),
            Expanded(
              child: BlocBuilder<CategoryListBloc, CategoryListState>(
                builder: (context, categoryState) {
                  if (categoryState is CategoryListSuccess) {
                    final categoryList = categoryState.categoryList;

                    return BlocBuilder<GetAllTasksBloc, GetAllTasksState>(
                      builder: (context, taskState) {
                        if (taskState is GetAllTasksSuccess) {
                          final taskList = taskState.tasks.allTasks;
                          taskList.sort(
                            (a, b) => a.priority.compareTo(b.priority),
                          );

                          if (taskList.isEmpty) {
                            return Center(
                              child: Column(
                                children: [
                                  Image.asset(AppImages.checklist),
                                  SizedBox(height: ResponsiveHelper.hPixel(10)),
                                  Text(
                                    AppString.whatWant,
                                    style: AppTextStyles.normal20,
                                  ),
                                  SizedBox(height: ResponsiveHelper.hPixel(10)),
                                  Text(
                                    AppString.addTasks,
                                    style: AppTextStyles.normal16,
                                  ),
                                ],
                              ),
                            );
                          }
                          return ListView.separated(
                            itemCount: taskList.length,
                            separatorBuilder:
                                (context, index) => SizedBox(height: 16),
                            itemBuilder: (context, index) {
                              final task = taskList[index];

                              CategoryEntity? category;
                              try {
                                category = categoryList.categories.firstWhere(
                                  (cat) => cat.categoryId == task.categoryId,
                                );
                              } catch (e) {
                                category = null;
                              }

                              if (category == null) return const SizedBox();

                              return TaskWidget(
                                title: task.title,
                                dateTime: task.dateTime,
                                categoryName: category.categoryName,
                                categoryColor: Color(category.color),
                                icon: IconData(
                                  category.iconCode,
                                  fontFamily: category.fontFamily,
                                ),
                                priority: task.priority.toString(),
                                value: task.isCompleted,
                                onChanged: (val) {},
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    RouteNames.singleTaskPage,
                                    arguments: {
                                      'task': task,
                                      'category': category,
                                    },
                                  );
                                },
                              );
                            },
                          );
                        } else if (taskState is GetAllTasksLoading) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return Center(child: Text("Xatolik yuz berdi"));
                        }
                      },
                    );
                  } else if (categoryState is CategoryListLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Center(child: Text("Kategoriyalar yuklanmadi"));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
