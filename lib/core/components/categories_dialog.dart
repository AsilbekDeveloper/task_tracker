import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:task_tracker_app/core/app_text_styles.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/category_list/category_list_bloc.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/category_list/category_list_state.dart';

class CategoryPickerDialog extends StatelessWidget {
  const CategoryPickerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Dialog(
      backgroundColor: colorScheme.surface,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          constraints: BoxConstraints(
            maxHeight: 400.h,
            maxWidth: 300.w,
          ),
          child: BlocBuilder<CategoryListBloc, CategoryListState>(
            builder: (context, state) {
              if (state is CategoryListLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CategoryListError) {
                return Center(
                  child: Text(
                    "Error: ${state.errorMessage}",
                    style: AppTextStyles.bodyLarge,
                  ),
                );
              } else if (state is CategoryListSuccess) {
                final categories = state.categoryList.categoryList;
        
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
                      style: AppTextStyles.bodyMedium,
                    ),
                  );
                }
        
                return GridView.builder(
                  itemCount: uniqueCategories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.h,
                  ),
                  itemBuilder: (context, index) {
                    final category = uniqueCategories[index];
                    return GestureDetector(
                      onTap: () {
                        context.pop(category);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(category.color),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              IconData(category.iconCode, fontFamily: 'MaterialIcons'),
                              color: colorScheme.onSurface,
                              size: 30.w,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              category.categoryName,
                              style: AppTextStyles.bodyLarge,
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
                    style: AppTextStyles.bodyMedium,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
