class TaskModel {
  late int id;
  late final String taskName;
  late final DateTime startDate;
  late final bool highPriority;
  TaskModel({
    required this.id,
    required this.taskName,
    required this.startDate,
    required this.highPriority,
  });
}
