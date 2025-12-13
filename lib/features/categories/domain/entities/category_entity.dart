import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String categoryId;
  final String categoryName;
  final String userId;
  final int iconCode;
  final int color;

  const CategoryEntity({
    required this.categoryId,
    required this.categoryName,
    required this.userId,
    required this.iconCode,
    required this.color,
  });

  @override
  List<Object?> get props => [categoryId, categoryName, userId, iconCode, color];
}
