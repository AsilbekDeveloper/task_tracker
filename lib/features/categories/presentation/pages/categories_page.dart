import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:task_tracker_app/core/colors/app_colors.dart';
import 'package:task_tracker_app/core/routes/route_names.dart';
import 'package:task_tracker_app/core/utils/responsive_helper.dart';
import 'package:task_tracker_app/features/categories/domain/entities/category_entity.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/categories_event.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/category_list/category_list_bloc.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/category_list/category_list_state.dart';
import 'package:task_tracker_app/features/categories/presentation/widgets/category_widget.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  void initState() {
    super.initState();
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      context.read<CategoryListBloc>().add(
        CategoryListEvent(userId: currentUser.uid),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        titleSpacing: ResponsiveHelper.wPixel(24),
        automaticallyImplyLeading: false,
        title: Text(
          "Categories Page",
          style: TextStyle(color: AppColors.whiteColor),
        ),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.wPixel(24)),
        child: Column(
          children: [
            SizedBox(height: ResponsiveHelper.hPixel(10)),
            Expanded(
              child: BlocBuilder<CategoryListBloc, CategoryListState>(
                builder: (context, state) {
                  if (state is CategoryListLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CategoryListError) {
                    return Center(child: Text("Error: ${state.errorMessage}"));
                  } else if (state is CategoryListSuccess) {
                    final categories = state.categoryList.categories;

                    if (categories.isEmpty) {
                      return const Center(
                        child: Text('No categories available.'),
                      );
                    }

                    List<CategoryEntity> uniqueCategories = [];
                    List<String> uniqueNames = [];

                    for (var category in categories) {
                      if (!uniqueNames.contains(category.categoryName)) {
                        uniqueNames.add(category.categoryName);
                        uniqueCategories.add(category);
                        if (uniqueCategories.length == 3) break;
                      }
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
                        return CategoryCard(
                          categoryName: category.categoryName,
                          iconCode: category.iconCode,
                          fontFamily: category.fontFamily ?? 'MaterialIcons',
                          color: category.color,
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              RouteNames.singleCategoryPage,
                              arguments: {
                                'categoryId': category.categoryId,
                                'categoryName': category.categoryName,
                              },
                            );
                          },
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('No categories available.'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(
            context,
            RouteNames.createCategoryPage,
          );
          if (result == true) {
            final currentUser = FirebaseAuth.instance.currentUser;
            if (currentUser != null) {
              context.read<CategoryListBloc>().add(
                CategoryListEvent(userId: currentUser.uid),
              );
            }
          }
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(IconlyBold.plus),
      ),
    );
  }
}
