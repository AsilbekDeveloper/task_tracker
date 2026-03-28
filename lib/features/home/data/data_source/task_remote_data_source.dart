import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:task_tracker_app/features/home/data/models/task_model.dart';
import 'package:task_tracker_app/features/home/data/models/task_list_model.dart';
import 'package:task_tracker_app/features/home/domain/entities/task_entity.dart';
import 'package:task_tracker_app/features/home/domain/entities/task_list_entity.dart';
import 'package:task_tracker_app/generated/strings.g.dart';

abstract class TaskRemoteDataSource {
  Future<TaskListEntity> getAllTasks({required String userId});
  Future<TaskEntity> createTask({required TaskEntity taskEntity});
  Future<void> deleteTask({required String taskId});
  Future<TaskEntity> editTask({required TaskEntity taskEntity});
  Future<void> updateTaskStatus({
    required String taskId,
    required bool isCompleted,
  });
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final logger = Logger();

  TaskRemoteDataSourceImpl(this.firebaseFirestore);

  @override
  Future<TaskEntity> createTask({required TaskEntity taskEntity}) async {
    try {
      final docRef = await firebaseFirestore.collection('tasks').add({
        'title': taskEntity.title,
        'description': taskEntity.description,
        'categoryId': taskEntity.categoryId,
        'priority': taskEntity.priority,
        'dateTime': Timestamp.fromDate(taskEntity.dateTime),
        'endTime': Timestamp.fromDate(taskEntity.endTime),
        'isCompleted': taskEntity.isCompleted,
        'userId': taskEntity.userId,
      });

      logger.i("Task created successfully with id: ${docRef.id}");

      return TaskEntity(
        taskId: docRef.id,
        title: taskEntity.title,
        description: taskEntity.description,
        categoryId: taskEntity.categoryId,
        priority: taskEntity.priority,
        dateTime: taskEntity.dateTime,
        endTime: taskEntity.endTime,
        isCompleted: taskEntity.isCompleted,
        userId: taskEntity.userId,
      );
    } catch (e) {
      logger.e("Error creating task: $e");
      throw Exception("${t.errors.failedToCreateTask} $e");
    }
  }


  @override
  Future<TaskListEntity> getAllTasks({required String userId}) async {
    try {
      final snapshot = await firebaseFirestore
          .collection('tasks')
          .where('userId', isEqualTo: userId)
          .get();

      logger.i("Tasks fetched: ${snapshot.docs.length}");

      final tasks = snapshot.docs.map((doc) {
        final data = doc.data();
        return TaskModel.fromJson(data, doc.id);
      }).toList();

      return TaskListModel(allTasks: tasks);
    } catch (e) {
      logger.e("Error fetching tasks: $e");
      throw Exception("${t.errors.fetchTasksError} $e");
    }
  }

  @override
  Future<void> deleteTask({required String taskId}) async {
    try {
      await firebaseFirestore.collection('tasks').doc(taskId).delete();
      logger.i("Task deleted successfully with id: $taskId");
    } catch (e) {
      logger.e("Error deleting task: $e");
      throw Exception("${t.errors.deleteTaskError} $e");
    }
  }


  @override
  Future<TaskEntity> editTask({required TaskEntity taskEntity}) async {
    try {
      await firebaseFirestore.collection('tasks').doc(taskEntity.taskId).update({
        'title': taskEntity.title,
        'description': taskEntity.description,
        'categoryId': taskEntity.categoryId,
        'priority': taskEntity.priority,
        'dateTime': Timestamp.fromDate(taskEntity.dateTime),
        'endTime': Timestamp.fromDate(taskEntity.endTime),
        'isCompleted': taskEntity.isCompleted,
        'userId': taskEntity.userId,
      });

      logger.i("Task updated successfully with id: ${taskEntity.taskId}");
      return taskEntity;
    } catch (e) {
      logger.e("Error updating task: $e");
      throw Exception("${t.errors.failedToUpdateTask} $e");
    }
  }

  @override
  Future<void> updateTaskStatus({
    required String taskId,
    required bool isCompleted,
  }) async {
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(taskId)
        .update({
      'isCompleted': isCompleted,
    });
  }
}
