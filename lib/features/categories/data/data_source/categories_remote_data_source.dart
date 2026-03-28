import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:task_tracker_app/features/categories/data/models/category_list_model.dart';
import 'package:task_tracker_app/features/categories/data/models/category_model.dart';
import 'package:task_tracker_app/features/categories/domain/entities/category_entity.dart';
import 'package:task_tracker_app/features/categories/domain/entities/category_list_entity.dart';
import 'package:task_tracker_app/generated/strings.g.dart';

abstract class CategoriesRemoteDataSource {
  Future<CategoryListEntity> getCategoryList({required String userId});

  Future<CategoryEntity> createCategory({
    required String categoryName,
    required String userId,
    required int iconCode,
    required int color,
  });

  Future<CategoryEntity> editCategory({
    required String categoryId,
    required String categoryName,
    required int iconCode,
    required int color,
  });

  Future<void> addDefaultCategories({required String userId});

  Future<void> deleteCategory({required String categoryId});
}

class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final logger = Logger();

  CategoriesRemoteDataSourceImpl(this.firebaseFirestore);

  @override
  Future<CategoryListModel> getCategoryList({required String userId}) async {
    try {
      if (userId.isEmpty) {
        throw Exception(t.errors.userIdEmpty);
      }

      logger.i("Fetching categories for userId: $userId");

      final snapshot =
      await firebaseFirestore
          .collection("categories")
          .where("userId", isEqualTo: userId)
          .get();

      logger.i("Snapshot retrieved: ${snapshot.docs.length} documents");

      final categories = snapshot.docs.map((doc) {
        final data = doc.data();
        return CategoryModel.fromJson(data, doc.id);
      }).toList();

      logger.i("Categories fetched successfully: ${categories.length}");

      return CategoryListModel(categoryList: categories);
    } catch (e) {
      logger.e("Error fetching categories: $e");
      throw Exception('${t.errors.fetchCategoriesError} $e');
    }
  }

  @override
  Future<CategoryEntity> createCategory({
    required String categoryName,
    required String userId,
    required int iconCode,
    required int color,
  }) async {
    try {
      final docRef = await firebaseFirestore.collection("categories").add({
        "name": categoryName,
        "userId": userId,
        "iconCode": iconCode,
        "color": color,
      });

      logger.i("Category created: $categoryName");

      return CategoryModel(
        categoryId: docRef.id,
        categoryName: categoryName,
        userId: userId,
        iconCode: iconCode,
        color: color,
      );
    } catch (e) {
      logger.e("Error creating category: $e");
      throw Exception("${t.errors.createCategoryError} $e");
    }
  }

  @override
  Future<void> addDefaultCategories({required String userId}) async {
    try {
      final userRef = firebaseFirestore.collection('users').doc(userId);

      final userSnapshot = await userRef.get();

      if (!userSnapshot.exists) {
        await userRef.set({
          'hasDefaultCategories': false,
        });
      }

      final hasDefault =
          userSnapshot.data()?['hasDefaultCategories'] ?? false;

      if (hasDefault) return;

      final categoriesRef = firebaseFirestore.collection('categories');

      final defaultCategories = [
        {
          'name': 'Work',
          'iconCode': Icons.work.codePoint,
          'color': Colors.blue.toARGB32(),
        },
        {
          'name': 'Study',
          'iconCode': Icons.school.codePoint,
          'color': Colors.green.toARGB32(),
        },
        {
          'name': 'Life',
          'iconCode': Icons.favorite.codePoint,
          'color': Colors.red.toARGB32(),
        },
      ];

      for (final category in defaultCategories) {
        await categoriesRef.add({
          'name': category['name'],
          'userId': userId,
          'iconCode': category['iconCode'],
          'color': category['color'],
        });
      }

      await userRef.update({
        'hasDefaultCategories': true,
      });
    } catch (e) {
      throw Exception('${t.errors.createDefaultCategoryError} $e');
    }
  }

  @override
  Future<void> deleteCategory({required String categoryId}) async {
    try {
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryId)
          .delete();
    } catch (e) {
      throw Exception("${t.errors.deleteCategoryError} ${e.toString()}");
    }
  }

  @override
  Future<CategoryEntity> editCategory({
    required String categoryId,
    required String categoryName,
    required int iconCode,
    required int color,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryId)
          .update({
        'name': categoryName,
        'iconCode': iconCode,
        'color': color,
      });

      return CategoryModel(
        categoryId: categoryId,
        categoryName: categoryName,
        userId: '',
        iconCode: iconCode,
        color: color,
      );
    } catch (e) {
      logger.e("Error updating category: $e");
      throw Exception("${t.errors.updateDataError}}$e");
    }
  }

}
