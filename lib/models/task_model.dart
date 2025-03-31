class TaskModel {
  final int? id; // Made non-nullable
  late final String taskName; // Made non-nullable
  final DateTime startDate; // Made non-nullable
  TaskModel({this.id, required this.taskName, required this.startDate});
}
