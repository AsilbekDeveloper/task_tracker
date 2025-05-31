import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tracker_app/core/colors/app_colors.dart';
import 'package:task_tracker_app/core/utils/responsive_helper.dart';
import 'package:task_tracker_app/core/app_text_styles.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/category_list/category_list_bloc.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/category_list/category_list_state.dart';

class CategoryPickerDialog extends StatelessWidget {
  const CategoryPickerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);
    return Dialog(
      backgroundColor: AppColors.backgroundColor,
      child: Container(
        padding: EdgeInsets.all(16),
        constraints: BoxConstraints(
          maxHeight: ResponsiveHelper.hPixel(400),
          maxWidth: ResponsiveHelper.wPixel(300),
        ),
        child: BlocBuilder<CategoryListBloc, CategoryListState>(
          builder: (context, state) {
            if (state is CategoryListLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CategoryListError) {
              return Center(
                child: Text(
                  "Error: ${state.errorMessage}",
                  style: AppTextStyles.normal16,
                ),
              );
            } else if (state is CategoryListSuccess) {
              final categories = state.categoryList.categories;

              final List<String> uniqueNames = [];
              final uniqueCategories = categories.where((cat) {
                if (uniqueNames.contains(cat.categoryName)) {
                  return false;
                } else {
                  uniqueNames.add(cat.categoryName);
                  return true;
                }
              }).toList();

              if (uniqueCategories.isEmpty) {
                return Center(
                  child: Text(
                    'No categories available.',
                    style: AppTextStyles.normal16,
                  ),
                );
              }

              return GridView.builder(
                itemCount: uniqueCategories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final category = uniqueCategories[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(category);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(category.color),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            IconData(category.iconCode,
                                fontFamily: category.fontFamily ?? 'MaterialIcons'),
                            color: AppColors.whiteColor,
                            size: 30,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            category.categoryName,
                            style: AppTextStyles.normal12.copyWith(color: AppColors.whiteColor),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text(
                  'No categories available.',
                  style: AppTextStyles.normal16,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
