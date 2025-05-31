import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tracker_app/components/text_field_widget.dart';
import 'package:task_tracker_app/core/app_text_styles.dart';
import 'package:task_tracker_app/core/colors/app_colors.dart';
import 'package:task_tracker_app/core/strings/app_string.dart';
import 'package:task_tracker_app/core/utils/responsive_helper.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/categories_event.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/category_list/category_list_bloc.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/create_category/create_category_bloc.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/create_category/create_category_state.dart';
import 'package:task_tracker_app/features/categories/presentation/widgets/color_selector_widget.dart';
import 'package:task_tracker_app/features/categories/presentation/widgets/icon_dialog_widget.dart';

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
    ResponsiveHelper.init(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: BlocConsumer<CreateCategoryBloc, CreateCategoryState>(
          listener: (context, state) {
            if (state is CreateCategoryLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => const Center(child: CircularProgressIndicator()),
              );
            } else {
              Navigator.of(context, rootNavigator: true).pop();
            }

            if (state is CreateCategorySuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Kategoriya yaratildi!")),
              );
              final userId = FirebaseAuth.instance.currentUser!.uid;
              context.read<CategoryListBloc>().add(CategoryListEvent(userId: userId));
              Navigator.pop(context, true);
            }

            if (state is CreateCategoryError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.wPixel(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: ResponsiveHelper.hPixel(20)),
                  Text(AppString.createNewCategory, style: AppTextStyles.bold20),
                  SizedBox(height: ResponsiveHelper.hPixel(20)),
                  Text(AppString.categoryNaming, style: AppTextStyles.normal16),
                  SizedBox(height: ResponsiveHelper.hPixel(16)),
                  TextFieldWidget(
                    controller: categoryNameController,
                    text: AppString.categoryName,
                  ),
                  SizedBox(height: ResponsiveHelper.hPixel(20)),
                  Text(AppString.categoryIcon, style: AppTextStyles.normal16),
                  SizedBox(height: ResponsiveHelper.hPixel(16)),
                  Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => IconDialogWidget(
                                onIconSelected: (icon) {
                                  setState(() {
                                    selectedIcon = icon;
                                  });
                                },
                              ),
                            );
                          },
                          height: 48,
                          color: AppColors.secondBgColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            selectedIcon == null ? AppString.chooseIcon : "Change Icon",
                            style: AppTextStyles.regularText2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      if (selectedIcon != null)
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            selectedIcon,
                            color: Colors.black87,
                            size: 28,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: ResponsiveHelper.hPixel(20)),
                  Text(AppString.categoryColor, style: AppTextStyles.normal16),
                  SizedBox(height: ResponsiveHelper.hPixel(16)),
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
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: ResponsiveHelper.wPixel(154),
                          height: ResponsiveHelper.hPixel(48),
                          alignment: Alignment.center,
                          child: Text(
                            "Cancel",
                            style: AppTextStyles.primaryTextColor,
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
                              const SnackBar(
                                  content: Text("Iltimos, barcha maydonlarni to‘ldiring")),
                            );
                            return;
                          }

                          final currentUser = FirebaseAuth.instance.currentUser;
                          if (currentUser == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Foydalanuvchi tizimga kirgan emas")),
                            );
                            return;
                          }

                          context.read<CreateCategoryBloc>().add(
                            CreateCategoryEvent(
                              userId: currentUser.uid,
                              categoryName: name,
                              icon: icon,
                              color: color,
                            ),
                          );
                        },
                        child: Container(
                          width: ResponsiveHelper.wPixel(154),
                          height: ResponsiveHelper.hPixel(48),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "Create Category",
                            style: AppTextStyles.normal16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: ResponsiveHelper.hPixel(20)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
