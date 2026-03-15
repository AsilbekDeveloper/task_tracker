import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:task_tracker_app/core/router/route_names.dart';
import 'package:task_tracker_app/generated/strings.g.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/category_list/category_list_bloc.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/category_list/category_list_event.dart';
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
    context.read<CategoryListBloc>().add(LoadCategories());
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        titleSpacing: 24.w,
        automaticallyImplyLeading: false,
        title: Text(
          t.category.categoriesPage,
          style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onSurface),
        ),
        backgroundColor: theme.colorScheme.surface,
        iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Expanded(
              child: BlocBuilder<CategoryListBloc, CategoryListState>(
                builder: (context, state) {
                  if (state is CategoryListLoading) {
                    return Center(
                      child: CircularProgressIndicator(color: theme.colorScheme.primary),
                    );
                  } else if (state is CategoryListError) {
                    return Center(
                      child: Text(
                        "${t.category.errorLoadingCategories}: ${state.errorMessage}",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface),
                      ),
                    );
                  } else if (state is CategoryListSuccess) {
                    final categories = state.categoryList.categoryList;

                    if (categories.isEmpty) {
                      return Center(
                        child: Text(
                          t.category.noCategoriesAvailable,
                          style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface),
                        ),
                      );
                    }

                    final seenNames = <String>{};
                    final uniqueCategories = categories
                        .where((cat) => seenNames.add(cat.categoryName))
                        .toList();

                    return GridView.builder(
                      itemCount: uniqueCategories.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 10.h,
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
                              queryParameters: {"name": category.categoryName},
                            );
                          },
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text(
                        t.category.noCategoriesAvailable,
                        style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface),
                      ),
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
        backgroundColor: theme.colorScheme.primary,
        onPressed: () async {
          final result = await context.pushNamed(RouteNames.createCategory);

          if (mounted && result == true) {
            context.read<CategoryListBloc>().add(LoadCategories());
          }
        },
        child: Icon(IconlyBold.plus, color: theme.colorScheme.onPrimary),
      ),
    );
  }
}
