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
import 'package:task_tracker_app/features/categories/data/models/category_model.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/create_task/create_task_bloc.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/create_task/create_task_event.dart';
import 'package:task_tracker_app/features/home/presentation/bloc/create_task/create_task_state.dart';
import 'package:task_tracker_app/generated/strings.g.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  int? _priority;
  DateTime? _endTime;
  CategoryModel? _selectedCategory;

  bool get _isFormValid =>
      _titleController.text.trim().isNotEmpty &&
          _selectedCategory != null &&
          _priority != null;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _pickCategory() async {
    final result = await showDialog<CategoryModel>(
      context: context,
      builder: (_) => const CategoryPickerDialog(),
    );

    if (result != null) {
      setState(() => _selectedCategory = result);
    }
  }

  Future<void> _pickPriority() async {
    final result = await showDialog<int>(
      context: context,
      builder: (_) => const PriorityWidget(),
    );

    if (result != null) {
      setState(() => _priority = result);
    }
  }

  void _createTask() {
    if (!_isFormValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Please fill required fields"),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    context.read<CreateTaskBloc>().add(
      CreateTaskButtonPressed(
        title: _titleController.text.trim(),
        description: _descController.text.trim(),
        categoryId: _selectedCategory!.categoryId,
        priority: _priority!,
        endTime: _endTime,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final labelStyle = AppTextStyles.bodyLarge.copyWith(color: cs.onSurface);


    return BlocListener<CreateTaskBloc, CreateTaskState>(
      listener: (context, state) {
        if (state is CreateTaskSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(t.task.taskCreatedSuccess),
              backgroundColor: cs.primary,
            ),
          );
          context.pop(true);
        }

        if (state is CreateTaskValidationError ||
            state is CreateTaskError) {
          final message = (state as dynamic).errorMessage;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: cs.error,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            t.task.addTask,
            style: AppTextStyles.bodyLarge,
          ),
          leading: IconButton(
            icon: const Icon(IconsaxPlusLinear.close_circle),
            onPressed: () => context.pop(),
          ),
        ),

        // MUHIM: Button pastda doim ko‘rinadi
        bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w,
              MediaQuery.of(context).viewInsets.bottom + 20.h),
          child: BlocBuilder<CreateTaskBloc, CreateTaskState>(
            builder: (context, state) {
              final isLoading = state is CreateTaskLoading;

              return MainButton(
                text: isLoading
                    ? t.task.creating
                    : t.task.createTask,
                onPressed:
                (isLoading) ? null : _createTask,
              );
            },
          ),
        ),

        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),

              /// Title
              Text(t.task.taskTitle, style: labelStyle),
              SizedBox(height: 8.h),
              TextFieldWidget(
                controller: _titleController,
                text: t.task.enterTaskTitle,
              ),

              SizedBox(height: 20.h),

              /// Description
              Text(t.task.taskDesc, style: labelStyle),
              SizedBox(height: 8.h),
              TextFieldWidget(
                controller: _descController,
                text: t.task.enterTaskDesc,
              ),

              SizedBox(height: 30.h),

              /// Time
              _buildRow(
                icon: IconsaxPlusLinear.timer_1,
                title: t.task.taskTime,
                trailing: TaskTimeWidget(
                  initialDateTime: _endTime,
                  onDateTimeSelected: (value) {
                    setState(() => _endTime = value);
                  },
                ),
                labelStyle: labelStyle,
              ),

              SizedBox(height: 30.h),

              /// Category
              _buildRow(
                icon: IconsaxPlusLinear.tag,
                title: t.task.taskCategory,
                trailing: ButtonWidget(
                  onPressed: _pickCategory,
                  child: Text(
                    _selectedCategory?.categoryName ??
                        t.category.select,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: cs.onSurface
                    ),
                  ),
                ),
                labelStyle: labelStyle,
              ),

              SizedBox(height: 30.h),

              /// Priority
              _buildRow(
                icon: IconsaxPlusLinear.flag,
                title: t.task.taskPriority,
                trailing: ButtonWidget(
                  onPressed: _pickPriority,
                  child: Text(
                    _priority == null
                        ? t.category.select
                        : "${t.task.priority}: $_priority",
                    style: AppTextStyles.headlineMedium.copyWith(
                      color: cs.onSurface
                    ),
                  ),
                ),
                labelStyle: labelStyle,
              ),

              SizedBox(height: 120.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow({
    required IconData icon,
    required String title,
    required Widget trailing,
    required TextStyle labelStyle,
  }) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.onSurface,),
        SizedBox(width: 8.w),
        Text(title, style: labelStyle),
        const Spacer(),
        trailing,
      ],
    );
  }
}