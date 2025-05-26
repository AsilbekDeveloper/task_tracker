import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:task_tracker_app/features/categories/data/models/category_list_model.dart';
import 'package:task_tracker_app/features/categories/data/models/category_model.dart';
import 'package:task_tracker_app/features/categories/domain/entities/category_entity.dart';
import 'package:task_tracker_app/features/categories/domain/entities/category_list_entity.dart';

abstract class CategoriesRemoteDataSource {
  Future<CategoryListEntity> getCategoryList({required String userId});
  Future<CategoryEntity> createCategory({
    required String categoryName,
    required String userId,
    required int iconCode,
    required String? fontFamily,
    required int color,
  });
  Future<void> addDefaultCategoriesForUser(String userId);
}

class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final logger = Logger();

  CategoriesRemoteDataSourceImpl(this.firebaseFirestore);

  @override
  Future<CategoryListModel> getCategoryList({required String userId}) async {
    try {
      if (userId.isEmpty) {
        throw Exception("UserId cannot be empty");
      }

      logger.i("Fetching categories for userId: $userId");

      final snapshot = await firebaseFirestore
          .collection("categories")
          .where("userId", isEqualTo: userId)
          .get();

      logger.i("Snapshot retrieved: ${snapshot.docs.length} documents");

      final categories = snapshot.docs.map((doc) {
        final data = doc.data();
        return CategoryModel.fromJson(data, doc.id);
      }).toList();

      logger.i("Categories fetched successfully: ${categories.length}");

      return CategoryListModel(categories: categories);
    } catch (e) {
      logger.e("Error fetching categories: $e");
      throw Exception('Kategoriya roʻyxatini olishda xatolik: $e');
    }
  }

  @override
  Future<CategoryEntity> createCategory({
    required String categoryName,
    required String userId,
    required int iconCode,
    required String? fontFamily,
    required int color,
  }) async {
    try {
      final docRef = await firebaseFirestore.collection("categories").add({
        "name": categoryName,
        "userId": userId,
        "iconCode": iconCode,
        "fontFamily": fontFamily,
        "color": color,
      });

      logger.i("Category created: $categoryName");

      return CategoryModel(
        categoryId: docRef.id,
        categoryName: categoryName,
        userId: userId,
        iconCode: iconCode,
        fontFamily: fontFamily,
        color: color,
      );
    } catch (e) {
      logger.e("Error creating category: $e");
      throw Exception("Kategoriya yaratishda xatolik: $e");
    }
  }

  @override
  Future<void> addDefaultCategoriesForUser(String userId) async {
    try {
      final collection = firebaseFirestore.collection('categories');

      final snapshot = await collection
          .where("userId", isEqualTo: userId)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        logger.i("Default categories already exist for user: $userId");
        return;
      }
      logger.i("Creating default categories for user: $userId");

      final defaultCategories = [
        {
          'name': 'Work',
          'iconCode': Icons.work.codePoint,
          'fontFamily': Icons.work.fontFamily,
          'color': Colors.blue.value,
        },
        {
          'name': 'Study',
          'iconCode': Icons.school.codePoint,
          'fontFamily': Icons.school.fontFamily,
          'color': Colors.green.value,
        },
        {
          'name': 'Life',
          'iconCode': Icons.favorite.codePoint,
          'fontFamily': Icons.favorite.fontFamily,
          'color': Colors.red.value,
        },
      ];

      for (var category in defaultCategories) {
        await collection.add({
          'name': category['name'],
          'userId': userId,
          'iconCode': category['iconCode'],
          'fontFamily': category['fontFamily'],
          'color': category['color'],
        });
      }

      logger.i("Default categories created for user: $userId");
    } catch (e) {
      logger.e("Error adding default categories: $e");
      throw Exception("Default kategoriyalarni qoʻshishda xatolik: $e");
    }
  }
}
