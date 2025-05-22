import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:task_tracker_app/core/colors/app_colors.dart';
import 'package:task_tracker_app/core/routes/route_names.dart';
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
    _loadUserIdAndDispatch();
  }

  void _loadUserIdAndDispatch() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      context.read<CategoryListBloc>().add(
        CategoryListEvent(userId: currentUser.uid),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          "Categories Page",
          style: TextStyle(color: AppColors.whiteColor),
        ),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 10),
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
                    return GridView.builder(
                      itemCount: categories.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return CategoryCard(
                          categoryName: category.categoryName,
                          iconCode: category.iconCode,
                          // default icon code
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
            _loadUserIdAndDispatch();
          }
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(IconlyBold.plus),
      ),
    );
  }
}
