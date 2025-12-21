import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:task_tracker_app/core/colors/app_colors.dart';
import 'package:task_tracker_app/core/router/route_names.dart';
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
          style: const TextStyle(color: AppColors.whiteColor),
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
                    final categories = state.categoryList.categoryList;

                    if (categories.isEmpty) {
                      return const Center(
                        child: Text('No categories available.'),
                      );
                    }

                    final seenNames = <String>{};
                    final uniqueCategories = categories
                        .where((cat) => seenNames.add(cat.categoryName))
                        .toList();

                    return GridView.builder(
                      itemCount: uniqueCategories.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        final category = uniqueCategories[index];
                        return CategoryCard(
                          categoryName: category.categoryName,
                          iconCode: category.iconCode,
                          color: category.color,
                          onPressed: () {
                            context.pushNamed(
                              RouteNames.singleCategory,
                              pathParameters: {"id": category.categoryId},
                              queryParameters: {
                                "name": category.categoryName,
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
        heroTag: null,
        backgroundColor: AppColors.primaryColor,
        onPressed: () async {
          final result = await context.pushNamed(RouteNames.createCategory);

          if (mounted && result == true) {
            final currentUser = FirebaseAuth.instance.currentUser;
            if (currentUser != null) {
              context.read<CategoryListBloc>().add(
                CategoryListEvent(userId: currentUser.uid),
              );
            }
          }
        },
        child: const Icon(IconlyBold.plus),
      ),
    );
  }
}
