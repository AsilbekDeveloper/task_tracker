import 'package:equatable/equatable.dart';
import 'package:task_tracker_app/features/home/domain/entities/task_entity.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}
