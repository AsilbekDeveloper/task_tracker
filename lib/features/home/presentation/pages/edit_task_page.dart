import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:task_tracker_app/components/button_widget.dart';
import 'package:task_tracker_app/components/categories_dialog.dart';
import 'package:task_tracker_app/components/main_button.dart';
import 'package:task_tracker_app/components/priority_widget.dart';
import 'package:task_tracker_app/components/task_time_widget.dart';
import 'package:task_tracker_app/components/text_field_widget.dart';
import 'package:task_tracker_app/core/app_text_styles.dart';
import 'package:task_tracker_app/core/colors/app_colors.dart';
import 'package:task_tracker_app/core/routes/route_names.dart';
import 'package:task_tracker_app/core/strings/app_string.dart';
import 'package:task_tracker_app/core/utils/responsive_helper.dart';
import 'package:task_tracker_app/features/categories/data/models/category_model.dart';
import 'package:task_tracker_app/features/home/domain/entities/task_entity.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/edit_task/edit_task_bloc.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/edit_task/edit_task_state.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/get_all_tasks/get_all_tasks_bloc.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/task_event.dart';

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

    _selectedCategory = widget.category ??
        CategoryModel(
          iconCode: Icons.question_mark.codePoint,
          fontFamily: 'MaterialIcons',
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
    if (taskTitleController.text.trim().isEmpty ||
        taskDescController.text.trim().isEmpty ||
        _endTime == null ||
        selectedPriority == null ||
        _selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Iltimos, barcha maydonlarni to‘ldiring.")),
      );
      return;
    }

    final editedTask = widget.task.copyWith(
      title: taskTitleController.text.trim(),
      description: taskDescController.text.trim(),
      endTime: _endTime!,
      categoryId: _selectedCategory!.categoryId,
      priority: selectedPriority!,
    );

    context.read<EditTaskBloc>().add(EditTaskEvent(taskEntity: editedTask));
  }


  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(IconsaxPlusLinear.close_circle, color: AppColors.whiteColor),
        ),
        title: Text("Edit Task", style: TextStyle(color: AppColors.whiteColor)),
      ),
      body: BlocConsumer<EditTaskBloc, EditTaskState>(
        listener: (context, state) {
          if (state is EditTaskSuccess) {
            context.read<GetAllTasksBloc>().add(GetAllTasksEvent(userId: widget.task.userId));
            Navigator.pushNamed(context, RouteNames.bottomNavbar,);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Vazifa muvaffaqiyatli tahrirlandi")),
            );
          } else if (state is EditTaskError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },

        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.wPixel(24)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: ResponsiveHelper.hPixel(10)),
                Text("Enter your task title", style: AppTextStyles.normal16),
                SizedBox(height: ResponsiveHelper.hPixel(10)),
                TextFieldWidget(controller: taskTitleController, text: AppString.taskTitle),
                SizedBox(height: ResponsiveHelper.hPixel(20)),
                Text("Enter your task description", style: AppTextStyles.normal16),
                SizedBox(height: ResponsiveHelper.hPixel(10)),
                TextFieldWidget(controller: taskDescController, text: AppString.taskDesc),
                SizedBox(height: ResponsiveHelper.hPixel(30)),
                Row(
                  children: [
                    Icon(IconsaxPlusLinear.timer_1, color: AppColors.whiteColor),
                    SizedBox(width: ResponsiveHelper.wPixel(8)),
                    Text("Task Time:", style: AppTextStyles.normal16),
                    const Spacer(),
                    TaskTimeWidget(
                      initialDateTime: _endTime,
                      onDateTimeSelected: (value) => setState(() => _endTime = value),
                    ),
                  ],
                ),
                SizedBox(height: ResponsiveHelper.hPixel(25)),
                Row(
                  children: [
                    Icon(IconsaxPlusLinear.tag, color: AppColors.whiteColor),
                    SizedBox(width: ResponsiveHelper.wPixel(8)),
                    Text("Task Category:", style: AppTextStyles.normal16),
                    const Spacer(),
                    ButtonWidget(
                      onPressed: _showCategoryDialog,
                      child: Row(
                        children: [
                          if (_selectedCategory != null) ...[
                            Icon(
                              IconData(
                                _selectedCategory!.iconCode,
                                fontFamily: _selectedCategory!.fontFamily ?? 'MaterialIcons',
                              ),
                              size: 18,
                              color: AppColors.whiteColor,
                            ),
                            const SizedBox(width: 6),
                            Text(_selectedCategory!.categoryName, style: AppTextStyles.normal12),
                          ] else
                            Text("Select", style: AppTextStyles.normal12),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ResponsiveHelper.hPixel(25)),
                Row(
                  children: [
                    Icon(IconsaxPlusLinear.chart_1, color: AppColors.whiteColor),
                    SizedBox(width: ResponsiveHelper.wPixel(8)),
                    Text("Task Priority:", style: AppTextStyles.normal16),
                    const Spacer(),
                    ButtonWidget(
                      child: Text(
                        selectedPriority != null
                            ? "Priority: $selectedPriority"
                            : "Priority tanlash",
                        style: AppTextStyles.normal12,
                      ),
                      onPressed: () async {
                        final result = await showDialog<int>(
                          context: context,
                          builder: (context) => const PriorityWidget(),
                        );
                        if (result != null) {
                          setState(() {
                            selectedPriority = result;
                          });
                        }
                      },
                    ),

                  ],
                ),
                SizedBox(height: ResponsiveHelper.hPixel(270)),
                MainButton(
                  text: state is EditTaskLoading ? "Loading..." : "Edit Task",
                  onPressed: state is EditTaskLoading ? null : _editTask,
                  isDisabled: state is EditTaskLoading,
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
