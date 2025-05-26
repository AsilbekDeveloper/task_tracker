class TaskEntity {
  final String taskId;
  final String title;
  final String description;
  final String categoryId;
  final bool isCompleted;
  final int priority;
  final DateTime dateTime;
  final DateTime endTime;
  final String userId;

  TaskEntity({
    required this.taskId,
    required this.title,
    required this.description,
    required this.categoryId,
    required this.isCompleted,
    required this.priority,
    required this.dateTime,
    required this.endTime,
    required this.userId,
  });

  TaskEntity copyWith({
    String? taskId,
    String? title,
    String? description,
    String? categoryId,
    bool? isCompleted,
    int? priority,
    DateTime? dateTime,
    DateTime? endTime,
    String? userId,
  }) {
    return TaskEntity(
      taskId: taskId ?? this.taskId,
      title: title ?? this.title,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      isCompleted: isCompleted ?? this.isCompleted,
      priority: priority ?? this.priority,
      dateTime: dateTime ?? this.dateTime,
      endTime: endTime ?? this.endTime,
      userId: userId ?? this.userId,
    );
  }
}
