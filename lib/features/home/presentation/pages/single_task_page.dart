import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:task_tracker_app/core/components/main_button.dart';
import 'package:task_tracker_app/core/router/route_names.dart';
import 'package:task_tracker_app/features/categories/domain/entities/category_entity.dart';
import 'package:task_tracker_app/features/home/domain/entities/task_entity.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/delete_task/delete_task_bloc.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/delete_task/delete_task_event.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/delete_task/delete_task_state.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/get_all_tasks/get_all_tasks_bloc.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/get_all_tasks/get_all_tasks_event.dart';
import 'package:task_tracker_app/generated/strings.g.dart';

class SingleTaskPage extends StatelessWidget {
  final TaskEntity task;
  final CategoryEntity category;

  const SingleTaskPage({super.key, required this.task, required this.category});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final theme = Theme.of(context);

    return BlocListener<DeleteTaskBloc, DeleteTaskState>(
      listener: (context, state) {
        if (state is DeleteTaskSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(t.task.taskEditedSuccessfully)),
          );
          context.read<GetAllTasksBloc>().add(GetAllTasksEvent(userId: task.userId));
          context.pop();
        } else if (state is DeleteTaskError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: AppBar(
          iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
          backgroundColor: theme.colorScheme.surface,
          actions: [
            BlocBuilder<DeleteTaskBloc, DeleteTaskState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: state is DeleteTaskLoading
                      ? null
                      : () {
                    context.read<DeleteTaskBloc>().add(DeleteTaskEvent(taskId: task.taskId));
                  },
                  icon: state is DeleteTaskLoading
                      ? CircularProgressIndicator(color: theme.colorScheme.primary)
                      : Icon(IconsaxPlusLinear.trash, color: theme.colorScheme.onSurface),
                );
              },
            ),
          ],
          title: Text(
            task.title,
            style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onSurface),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.h),

                // Task Title
                Text(t.task.taskTitle, style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onSurface)),
                SizedBox(height: 10.h),
                Text(task.title, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface)),
                SizedBox(height: 8.h),
                Divider(color: theme.colorScheme.onSurface.withOpacity(0.2)),
                SizedBox(height: 20.h),

                // Task Description
                Text(t.task.taskDesc, style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onSurface)),
                SizedBox(height: 10.h),
                Text(task.description, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface)),
                SizedBox(height: 8.h),
                Divider(color: theme.colorScheme.onSurface.withOpacity(0.2)),
                SizedBox(height: 20.h),

                // Task Time
                Text(t.task.taskTime, style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onSurface)),
                SizedBox(height: 10.h),
                Text(
                  "${task.dateTime.day.toString().padLeft(2, '0')}.${task.dateTime.month.toString().padLeft(2, '0')}.${task.dateTime.year} at ${task.dateTime.hour.toString().padLeft(2, '0')}:${task.dateTime.minute.toString().padLeft(2, '0')}",
                  style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface),
                ),
                SizedBox(height: 8.h),
                Divider(color: theme.colorScheme.onSurface.withOpacity(0.2)),
                SizedBox(height: 20.h),

                // Task Category
                Text(t.task.taskCategory, style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onSurface)),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Icon(
                      IconData(category.iconCode, fontFamily: "MaterialIcons"),
                      color: theme.colorScheme.onSurface,
                    ),
                    SizedBox(width: 10.w),
                    Text(category.categoryName, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface)),
                  ],
                ),
                SizedBox(height: 8.h),
                Divider(color: theme.colorScheme.onSurface.withOpacity(0.2)),
                SizedBox(height: 20.h),

                // Task Priority
                Text(t.task.taskPriority, style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onSurface)),
                SizedBox(height: 10.h),
                Text(task.priority.toString(), style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface)),
                SizedBox(height: 180.h),

                // Edit Button
                MainButton(
                  text: t.task.editTask,
                  onPressed: () {
                    context.pushNamed(
                      RouteNames.editTask,
                      pathParameters: {'id': task.taskId},
                      extra: {"task": task, "category": category},
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
