import 'package:equatable/equatable.dart';

abstract class CreateTaskEvent extends Equatable {
  const CreateTaskEvent();

  @override
  List<Object?> get props => [];
}

/// ✅ Event when user presses "Create Task" button
/// BLoC will validate and create task
class CreateTaskButtonPressed extends CreateTaskEvent {
  final String title;
  final String description;
  final String? categoryId;
  final int? priority;
  final DateTime? endTime;

  const CreateTaskButtonPressed({
    required this.title,
    required this.description,
    required this.categoryId,
    required this.priority,
    required this.endTime,
  });

  @override
  List<Object?> get props => [title, description, categoryId, priority, endTime];
}