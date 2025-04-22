import 'package:flutter_todo_practice_1/models/task_model.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  RxList<TaskModel> taskList = <TaskModel>[].obs;

  Future<void> createTask(String name, DateTime date, bool highPriority) async {
    final task = TaskModel(
      id: taskList.length + 1,
      taskName: name,
      startDate: date,
      highPriority: highPriority,
    );
    taskList.add(task);
    taskList.refresh();
  }

  Future<void> deleteTask(int index) async {
    taskList.removeAt(index);
    taskList.refresh();
  }

  Future<void> updateTask(int index, String name, DateTime date, bool highPriority) async {
    final task = TaskModel(id: index, taskName: name, startDate: date, highPriority: highPriority);
    taskList.removeAt(index);
    taskList.insert(index, task);
    taskList.refresh();
  }
}
