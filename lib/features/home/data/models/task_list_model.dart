import 'package:task_tracker_app/features/home/data/models/task_model.dart';
import 'package:task_tracker_app/features/home/domain/entities/task_list_entity.dart';

class TaskListModel extends TaskListEntity {
  TaskListModel({required super.allTasks});

  factory TaskListModel.fromSnapshot(List<Map<String, dynamic>> jsonList) {
    final tasks = <TaskModel>[];

    for (var json in jsonList) {
      if (json.containsKey('id') && json['data'] != null) {
        tasks.add(TaskModel.fromJson(json['data'], json['id']));
      }
    }

    return TaskListModel(allTasks: tasks);
  }

  factory TaskListModel.fromQuerySnapshot(Iterable<MapEntry<String, Map<String, dynamic>>> entries) {
    final tasks = entries.map((entry) {
      return TaskModel.fromJson(entry.value, entry.key);
    }).toList();

    return TaskListModel(allTasks: tasks);
  }

  List<Map<String, dynamic>> toJsonList() {
    return allTasks.map((task) {
      if (task is TaskModel) {
        return Map<String, dynamic>.from(task.toJson());
      }
      return <String, dynamic>{};
    }).toList();
  }

}
