import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:task_tracker_app/core/app_text_styles.dart';
import 'package:task_tracker_app/core/components/button_widget.dart';
import 'package:task_tracker_app/core/components/categories_dialog.dart';
import 'package:task_tracker_app/core/components/main_button.dart';
import 'package:task_tracker_app/core/components/priority_widget.dart';
import 'package:task_tracker_app/core/components/task_time_widget.dart';
import 'package:task_tracker_app/core/components/text_field_widget.dart';
import 'package:task_tracker_app/core/router/route_names.dart';
import 'package:task_tracker_app/features/categories/data/models/category_model.dart';
import 'package:task_tracker_app/features/home/domain/entities/task_entity.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/edit_task/edit_task_bloc.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/edit_task/edit_task_event.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/edit_task/edit_task_state.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/get_all_tasks/get_all_tasks_bloc.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/get_all_tasks/get_all_tasks_event.dart';
import 'package:task_tracker_app/generated/strings.g.dart';

class EditTaskPage extends StatefulWidget {
  final TaskEntity task;
  final CategoryModel? category;

  const EditTaskPage({super.key, required this.task, required this.category});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  late TextEditingController taskTitleController;
  late TextEditingController taskDescController;
  int? selectedPriority;
  DateTime? _endTime;
  CategoryModel? _selectedCategory;

  @override
  void initState() {
    super.initState();
    taskTitleController = TextEditingController(text: widget.task.title);
    taskDescController = TextEditingController(text: widget.task.description);
    selectedPriority = widget.task.priority;
    _endTime = widget.task.endTime;
    _selectedCategory =
        widget.category ??
        CategoryModel(
          iconCode: Icons.question_mark.codePoint,
          categoryId: '',
          categoryName: 'Unknown',
          userId: '',
          color: 0xFF000000,
        );
  }

  @override
  void dispose() {
    taskTitleController.dispose();
    taskDescController.dispose();
    super.dispose();
  }

  Future<void> _showCategoryDialog() async {
    final selectedCategory = await showDialog<CategoryModel>(
      context: context,
      builder: (_) => const CategoryPickerDialog(),
    );
    if (selectedCategory != null) {
      setState(() {
        _selectedCategory = selectedCategory;
      });
    }
  }

  void _editTask() {
    final editedTask = widget.task.copyWith(
      title: taskTitleController.text.trim(),
      description: taskDescController.text.trim(),
      endTime: _endTime,
      categoryId: _selectedCategory?.categoryId,
      priority: selectedPriority,
    );
    context.read<EditTaskBloc>().add(EditTaskEvent(taskEntity: editedTask));
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(
            IconsaxPlusLinear.close_circle,
            color: colorScheme.onSurface,
          ),
        ),
        title: Text(
          t.task.editTask,
          style: AppTextStyles.displayLarge.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
      ),
      body: BlocConsumer<EditTaskBloc, EditTaskState>(
        listener: (context, state) {
          if (state is EditTaskSuccess) {
            context.read<GetAllTasksBloc>().add(
              GetAllTasksEvent(userId: widget.task.userId),
            );
            context.pushNamed(RouteNames.bottomNavbar);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(t.task.taskEditedSuccessfully),
                backgroundColor: colorScheme.primary,
              ),
            );
          } else if (state is EditTaskError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: colorScheme.error,
              ),
            );
          } else if (state is EditTaskValidationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: colorScheme.secondary,
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),

                // Task title
                Text(
                  t.task.enterTaskTitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 10.h),
                TextFieldWidget(
                  controller: taskTitleController,
                  text: t.task.taskTitle,
                ),

                SizedBox(height: 20.h),

                // Task description
                Text(
                  t.task.enterTaskDesc,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 10.h),
                TextFieldWidget(
                  controller: taskDescController,
                  text: t.task.taskDesc,
                ),

                SizedBox(height: 30.h),

                // Task time
                Row(
                  children: [
                    Icon(
                      IconsaxPlusLinear.timer_1,
                      color: theme.colorScheme.onSurface,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      t.task.taskTime,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const Spacer(),
                    TaskTimeWidget(
                      initialDateTime: _endTime,
                      onDateTimeSelected:
                          (value) => setState(() => _endTime = value),
                    ),
                  ],
                ),

                SizedBox(height: 25.h),

                // Category picker
                Row(
                  children: [
                    Icon(
                      IconsaxPlusLinear.tag,
                      color: theme.colorScheme.onSurface,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      t.task.taskCategory,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const Spacer(),
                    ButtonWidget(
                      onPressed: _showCategoryDialog,
                      child: Row(
                        children: [
                          if (_selectedCategory != null) ...[
                            Icon(
                              IconData(
                                _selectedCategory!.iconCode,
                                fontFamily: 'MaterialIcons',
                              ),
                              size: 18.w,
                              color: theme.colorScheme.onSurface,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              _selectedCategory!.categoryName,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                          ] else
                            Text(
                              t.task.select,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 25.h),

                // Priority picker
                Row(
                  children: [
                    Icon(
                      IconsaxPlusLinear.chart_1,
                      color: theme.colorScheme.onSurface,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      t.task.taskPriority,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const Spacer(),
                    ButtonWidget(
                      child: Text(
                        selectedPriority != null
                            ? "${t.task.priority}: $selectedPriority"
                            : t.task.selectPriority,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      onPressed: () async {
                        final result = await showDialog<int>(
                          context: context,
                          builder: (context) => const PriorityWidget(),
                        );
                        if (result != null) {
                          setState(() => selectedPriority = result);
                        }
                      },
                    ),
                  ],
                ),

                SizedBox(height: 250.h),

                // Save button
                MainButton(
                  text:
                      state is EditTaskLoading
                          ? t.task.loading
                          : t.task.editTask,
                  onPressed: state is EditTaskLoading ? null : _editTask,
                ),

                SizedBox(height: 20.h),
              ],
            ),
          );
        },
      ),
    );
  }
}
