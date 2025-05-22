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
}
