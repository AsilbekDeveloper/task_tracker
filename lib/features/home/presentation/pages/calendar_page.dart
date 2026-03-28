import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:task_tracker_app/core/app_images_icons/app_images.dart';
import 'package:task_tracker_app/core/router/route_names.dart';
import 'package:task_tracker_app/generated/strings.g.dart';
import 'package:task_tracker_app/features/categories/domain/entities/category_entity.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/category_list/category_list_bloc.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/category_list/category_list_event.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/category_list/category_list_state.dart';
import 'package:task_tracker_app/features/home/domain/entities/task_entity.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/get_all_tasks/get_all_tasks_bloc.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/get_all_tasks/get_all_tasks_event.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/get_all_tasks/get_all_tasks_state.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/update_task/update_task_bloc.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/update_task/update_task_event.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/update_task/update_task_state.dart';
import 'package:task_tracker_app/features/home/presentation/widget/task_widget.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  static const int _daysToShow = 90;
  static const double _dateCardSpacing = 12.0;
  static const double _calendarHeight = 90.0;

  DateTime _selectedDate = DateTime.now();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadInitialData() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    context.read<GetAllTasksBloc>().add(GetAllTasksEvent(userId: user.uid));
    context.read<CategoryListBloc>().add(LoadCategories());
  }

  void _reloadData() => _loadInitialData();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode; // ilova tilini olish

    return MultiBlocListener(
      listeners: [
        BlocListener<UpdateTaskBloc, UpdateTaskState>(
          listener: (context, state) {
            if (state is UpdateTaskSuccess) {
              _reloadData();
            } else if (state is UpdateTaskError) {
              _showErrorSnackBar(state.message);
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: AppBar(
              backgroundColor: theme.colorScheme.surface,
              elevation: 0,
              title: Text(
                t.calendar.calendar,
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
              centerTitle: true,
            ),
          ),
        ),
        body: Column(
          children: [
            _buildHorizontalCalendar(theme, locale),
            Divider(
              color: theme.colorScheme.onSurface.withOpacity(0.1),
              height: 1,
            ),
            Expanded(
              child: BlocBuilder<CategoryListBloc, CategoryListState>(
                builder: (context, categoryState) {
                  return switch (categoryState) {
                    CategoryListLoading() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    CategoryListSuccess() =>
                        BlocBuilder<GetAllTasksBloc, GetAllTasksState>(
                          builder: (context, taskState) {
                            return switch (taskState) {
                              GetAllTasksLoading() => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              GetAllTasksSuccess() => _buildTasksContent(
                                taskState.tasks.allTasks,
                                categoryState.categoryList.categoryList,
                                theme,
                                locale,
                              ),
                              GetAllTasksError() => _buildErrorState(
                                taskState.errorMessage,
                                theme,
                              ),
                              _ => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            };
                          },
                        ),
                    CategoryListError() => _buildErrorState(
                      t.calendar.errorLoadingTasks,
                      theme,
                    ),
                    _ => const Center(child: CircularProgressIndicator()),
                  };
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalCalendar(ThemeData theme, String locale) {
    final cs = theme.colorScheme;

    final dates = List.generate(
      _daysToShow,
          (index) => DateTime.now().add(Duration(days: index)),
    );

    return SizedBox(
      height: _calendarHeight.h,
      child: ListView.separated(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: dates.length,
        separatorBuilder: (_, __) => SizedBox(width: _dateCardSpacing.w),
        itemBuilder: (context, index) {
          final date = dates[index];
          final isSelected = _isSameDay(date, _selectedDate);
          final isToday = _isSameDay(date, DateTime.now());

          final Color bgColor;
          final Color textColor;
          final Color subTextColor;
          final Border? border;

          if (isSelected) {
            bgColor = cs.primary;
            textColor = cs.onPrimary;
            subTextColor = cs.onPrimary.withOpacity(0.8);
            border = null;
          } else if (isToday) {
            bgColor = cs.primary.withOpacity(0.12);
            textColor = cs.primary;
            subTextColor = cs.primary.withOpacity(0.8);
            border = Border.all(
              color: cs.primary.withOpacity(0.3),
              width: 1,
            );
          } else {
            bgColor = cs.surface;
            textColor = cs.onSurface;
            subTextColor = cs.onSurface.withOpacity(0.5);
            border = Border.all(
              color: cs.onSurface.withOpacity(0.12),
              width: 1,
            );
          }

          return GestureDetector(
            onTap: () => setState(() => _selectedDate = date),
            child: Container(
              width: 70.w,
              padding: EdgeInsets.symmetric(vertical: 8.h),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12.r),
                border: border,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('MMM', locale).format(date).toUpperCase(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${date.day}',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    DateFormat('EEE', locale).format(date).toUpperCase(),
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400,
                      color: subTextColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTasksContent(
      List<TaskEntity> tasks,
      List<CategoryEntity> categories,
      ThemeData theme,
      String locale,
      ) {
    final t = Translations.of(context);

    final filtered =
    tasks.where((task) => _isSameDay(task.dateTime, _selectedDate)).toList()
      ..sort((a, b) => a.priority.compareTo(b.priority));

    if (filtered.isEmpty) return _buildEmptyState(theme);

    final completed = filtered.where((e) => e.isCompleted).length;
    final headerText = t.calendar.tasksCompleted
        .replaceAll("{completed}", completed.toString())
        .replaceAll("{total}", filtered.length.toString());

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          Text(
            DateFormat('EEEE, MMMM d', locale).format(_selectedDate),
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            headerText,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onBackground.withOpacity(0.7),
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: ListView.separated(
              itemCount: filtered.length,
              separatorBuilder: (_, __) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final task = filtered[index];
                final category = categories.firstWhere(
                      (c) => c.categoryId == task.categoryId,
                );

                return TaskWidget(
                  title: task.title,
                  dateTime: task.dateTime,
                  categoryName: category.categoryName,
                  categoryColor: Color(category.color),
                  icon: IconData(
                    category.iconCode,
                    fontFamily: 'MaterialIcons',
                  ),
                  priority: task.priority.toString(),
                  value: task.isCompleted,
                  onChanged: (value) {
                    if (value == null) return;
                    context.read<UpdateTaskBloc>().add(
                      UpdateTaskStatusEvent(
                        taskId: task.taskId,
                        isCompleted: value,
                      ),
                    );
                  },
                  onPressed: () {
                    context.pushNamed(
                      RouteNames.singleTask,
                      pathParameters: {'id': task.taskId},
                      extra: {"task": task, "category": category},
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message, ThemeData theme) {
    final t = Translations.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: theme.colorScheme.error,
            size: 48.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            t.calendar.errorLoadingTasks,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            message,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: _reloadData,
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
            ),
            child: Text(
              t.calendar.tryAgain,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    final t = Translations.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImages.checklist, width: 120.w),
          SizedBox(height: 24.h),
          Text(
            t.calendar.noTasksForDate,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;

    final theme = Theme.of(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: theme.colorScheme.error,
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}