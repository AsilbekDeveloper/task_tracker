class CategoryEntity {
  final String categoryId;
  final String categoryName;
  final String userId;
  final int iconCode;
  final String? fontFamily;
  final int color;

  CategoryEntity({
    required this.categoryId,
    required this.categoryName,
    required this.userId,
    required this.iconCode,
    required this.fontFamily,
    required this.color,
  });
}
