import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_tracker_app/features/home/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    required super.taskId,
    required super.title,
    required super.description,
    required super.categoryId,
    required super.priority,
    required super.dateTime,
    required super.endTime,
    required super.isCompleted,
    required super.userId,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json, String id) {
    return TaskModel(
      taskId: id,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      categoryId: json['categoryId'] ?? '',
      priority: json['priority'] ?? 0,
      dateTime: (json['dateTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
      endTime: (json['endTime'] as Timestamp).toDate(),
      isCompleted: json['isCompleted'] ?? false,
      userId: json["userId"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'categoryId': categoryId,
      'priority': priority,
      'dateTime': Timestamp.fromDate(dateTime),
      'endTime': Timestamp.fromDate(endTime),
      'isCompleted': isCompleted,
    };
  }
}