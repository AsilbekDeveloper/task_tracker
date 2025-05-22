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
import 'package:task_tracker_app/core/strings/app_string.dart';
import 'package:task_tracker_app/core/utils/responsive_helper.dart';
import 'package:task_tracker_app/features/categories/data/models/category_model.dart';
import 'package:task_tracker_app/features/home/domain/entities/task_entity.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/create_task/create_task_bloc.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/create_task/create_task_state.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/get_all_tasks/get_all_tasks_bloc.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/task_event.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskDescController = TextEditingController();

  int? selectedPriority;
  DateTime? _endTime;
  CategoryModel? _selectedCategory;

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

  void _createTask(BuildContext context) {
    if (taskTitleController.text.isEmpty ||
        taskDescController.text.isEmpty ||
        _endTime == null ||
        _selectedCategory == null ||
        selectedPriority == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Iltimos, barcha maydonlarni to'ldiring")),
      );
      return;
    }

    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    final newTask = TaskEntity(
      taskId: '',
      title: taskTitleController.text,
      description: taskDescController.text,
      categoryId: _selectedCategory!.categoryId,
      priority: selectedPriority!,
      dateTime: _endTime!,
      endTime: _endTime!,
      isCompleted: false,
      userId: userId,
    );

    context.read<CreateTaskBloc>().add(CreateTaskEvent(taskEntity: newTask));
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);

    return BlocListener<CreateTaskBloc, CreateTaskState>(
      listener: (context, state) {
        if (state is CreateTaskSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Task muvaffaqiyatli yaratildi!")),
          );
          final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
          context.read<GetAllTasksBloc>().add(GetAllTasksEvent(userId: userId));
          Navigator.pop(context);
        } else if (state is CreateTaskError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },

      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              IconsaxPlusLinear.close_circle,
              color: AppColors.whiteColor,
            ),
          ),
          title: Text(
            "Add Task Page",
            style: TextStyle(color: AppColors.whiteColor),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveHelper.wPixel(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: ResponsiveHelper.hPixel(10)),
                Text("Enter your task title", style: AppTextStyles.normal16),
                SizedBox(height: ResponsiveHelper.hPixel(10)),
                TextFieldWidget(
                  controller: taskTitleController,
                  text: AppString.taskTitle,
                ),
                SizedBox(height: ResponsiveHelper.hPixel(20)),
                Text(
                  "Enter your task description",
                  style: AppTextStyles.normal16,
                ),
                SizedBox(height: ResponsiveHelper.hPixel(10)),
                TextFieldWidget(
                  controller: taskDescController,
                  text: AppString.taskDesc,
                ),
                SizedBox(height: ResponsiveHelper.hPixel(40)),
                Row(
                  children: [
                    Icon(
                      IconsaxPlusLinear.timer_1,
                      color: AppColors.whiteColor,
                    ),
                    SizedBox(width: ResponsiveHelper.wPixel(8)),
                    Text("Task Time:", style: AppTextStyles.normal16),
                    const Spacer(),
                    TaskTimeWidget(
                      initialDateTime: _endTime,
                      onDateTimeSelected: (selectedDateTime) {
                        setState(() {
                          _endTime = selectedDateTime;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: ResponsiveHelper.hPixel(35)),
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
                                fontFamily:
                                    _selectedCategory!.fontFamily ??
                                    'MaterialIcons',
                              ),
                              size: 18,
                              color: AppColors.whiteColor,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              _selectedCategory!.categoryName,
                              style: AppTextStyles.normal12,
                            ),
                          ] else ...[
                            Text("Select", style: AppTextStyles.normal12),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ResponsiveHelper.hPixel(35)),
                Row(
                  children: [
                    Icon(IconsaxPlusLinear.tag, color: AppColors.whiteColor),
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
                SizedBox(height: ResponsiveHelper.hPixel(230)),
                SizedBox(
                  width: double.infinity,
                  child: BlocBuilder<CreateTaskBloc, CreateTaskState>(
                    builder: (context, state) {
                      return MainButton(
                        text:
                            state is CreateTaskLoading
                                ? "Yaratilmoqda..."
                                : "Create",
                        onPressed: () => _createTask(context),
                        isDisabled: state is CreateTaskLoading,
                      );
                    },
                  ),
                ),
                SizedBox(height: ResponsiveHelper.hPixel(30)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
