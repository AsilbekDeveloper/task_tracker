import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_tracker_app/components/categories_dialog.dart';
import 'package:task_tracker_app/features/categories/domain/entities/category_list_entity.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/category_list/category_list_bloc.dart';
import 'package:task_tracker_app/features/categories/presentation/bloc/category_list/category_list_state.dart';
import 'package:task_tracker_app/features/categories/data/models/category_model.dart';

class MockCategoryListBloc extends Mock implements CategoryListBloc {}

void main() {
  late CategoryListBloc mockBloc;

  setUp(() {
    mockBloc = MockCategoryListBloc();
  });

  Widget createWidgetUnderTest(Widget widget) {
    return MaterialApp(
      home: BlocProvider<CategoryListBloc>.value(
        value: mockBloc,
        child: Scaffold(body: widget),
      ),
    );
  }

  testWidgets('shows CircularProgressIndicator when loading', (tester) async {
    when(() => mockBloc.state).thenReturn(CategoryListLoading());

    await tester.pumpWidget(createWidgetUnderTest(const CategoryPickerDialog()));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows error text when error state', (tester) async {
    when(() => mockBloc.state).thenReturn(CategoryListError("Something went wrong"));

    await tester.pumpWidget(createWidgetUnderTest(const CategoryPickerDialog()));
    expect(find.textContaining("Error"), findsOneWidget);
  });

  testWidgets('shows categories in grid when success', (tester) async {
    final categories = [
      CategoryModel(
        categoryName: "Work",
        iconCode: Icons.work.codePoint,
        color: Colors.blue.value,
        fontFamily: "MaterialIcons", categoryId: '', userId: '',
      ),
      CategoryModel(
        categoryName: "Study",
        iconCode: Icons.book.codePoint,
        color: Colors.green.value,
        fontFamily: "MaterialIcons", categoryId: '', userId: '',
      ),
    ];

    when(() => mockBloc.state).thenReturn(
      CategoryListSuccess(
        CategoryListEntity(categories: categories),
      ),
    );

    await tester.pumpWidget(createWidgetUnderTest(const CategoryPickerDialog()));
    expect(find.text("Work"), findsOneWidget);
    expect(find.text("Study"), findsOneWidget);
    expect(find.byType(GridView), findsOneWidget);
  });
}
