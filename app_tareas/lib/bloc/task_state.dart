import 'package:equatable/equatable.dart';

class TaskState extends Equatable {
  final int taskId;
  final String description;
  final String date;
  final String labelName;
  final bool finish;

  const TaskState(
      {required this.taskId,
      this.description = '',
      required this.date,
      required this.labelName,
      this.finish = false});
  //Map
  factory TaskState.fromMap(Map taskMap) {
    return TaskState(
      taskId: taskMap['taskId'],
      description: taskMap['description'],
      date: taskMap['date'],
      labelName: taskMap['label'],
    );
  }
  copyWith({required bool finish}) {}
  @override
  // TODO: implement props
  List<Object?> get props => [taskId, description, date, labelName, finish];
}

class ListTaskState {
  final List<TaskState> tasks;
  ListTaskState(
    List<TaskState> newTasks, {
    List<TaskState>? tasks,
  }) : tasks = newTasks;
}
