import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:task_tracker_app/core/app_text_styles.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/category_list/category_list_bloc.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/category_list/category_list_event.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/create_category/create_category_bloc.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/create_category/create_category_event.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/create_category/create_category_state.dart';
import 'package:task_tracker_app/features/categories/presentation/widgets/color_selector_widget.dart';
import 'package:task_tracker_app/features/categories/presentation/widgets/icon_dialog_widget.dart';
import 'package:task_tracker_app/core/components/text_field_widget.dart';
import 'package:task_tracker_app/generated/strings.g.dart';

class CreateCategoryPage extends StatefulWidget {
  const CreateCategoryPage({super.key});

  @override
  State<CreateCategoryPage> createState() => _CreateCategoryPageState();
}

class _CreateCategoryPageState extends State<CreateCategoryPage> {
  final TextEditingController categoryNameController = TextEditingController();
  IconData? selectedIcon;
  Color? categoryColor;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        body: BlocConsumer<CreateCategoryBloc, CreateCategoryState>(
          listener: (context, state) {
            if (state is CreateCategoryLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder:
                    (_) => Center(
                      child: CircularProgressIndicator(
                        color: theme.colorScheme.primary,
                      ),
                    ),
              );
            } else {
              context.pop();
            }

            if (state is CreateCategorySuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(t.category.categoryCreatedSuccess)),
              );
              context.read<CategoryListBloc>().add(LoadCategories());
              context.pop(true);
            }

            if (state is CreateCategoryError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Text(
                    t.category.createNewCategory,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    t.category.categoryNaming,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextFieldWidget(
                    controller: categoryNameController,
                    text: t.category.categoryName,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    t.category.categoryIcon,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder:
                                  (_) => IconDialogWidget(
                                    onIconSelected: (icon) {
                                      setState(() {
                                        selectedIcon = icon;
                                      });
                                    },
                                  ),
                            );
                          },
                          height: 48,
                          color: theme.colorScheme.surfaceContainerHighest,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            selectedIcon == null
                                ? t.category.chooseIcon
                                : t.category.changeIcon,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      if (selectedIcon != null)
                        Container(
                          width: 48.w,
                          height: 48.h,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            selectedIcon,
                            color: theme.colorScheme.onSurface,
                            size: 28.w,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    t.category.categoryColor,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  ColorSelectorWidget(
                    onColorSelected: (color) {
                      setState(() {
                        categoryColor = color;
                      });
                    },
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Container(
                          width: 154.w,
                          height: 48.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.r),
                            color: theme.colorScheme.surfaceContainerHighest,
                          ),
                          child: Text(
                            t.category.cancel,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          final name = categoryNameController.text.trim();
                          final icon = selectedIcon;
                          final color = categoryColor;

                          if (name.isEmpty || icon == null || color == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(t.category.fillAllFields)),
                            );
                            return;
                          }

                          final currentUser = FirebaseAuth.instance.currentUser;
                          if (currentUser == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(t.auth.userNotLoggedIn)),
                            );
                            return;
                          }

                          context.read<CreateCategoryBloc>().add(
                            CreateCategory(
                              name: name,
                              icon: icon,
                              color: color,
                            ),
                          );
                        },
                        child: Container(
                          width: 154.w,
                          height: 48.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            t.category.createCategory,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
