import 'package:flutter_todo_practice_1/models/task_model.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  RxList<TaskModel> taskList = <TaskModel>[].obs;

  Future<void> createTask(String name, DateTime date) async {
    final task = TaskModel(
      id: taskList.length + 1,
      taskName: name,
      startDate: date,
      // startDate: DateTime(date.year, date.month, date.day),
      // startDate: DateUtils.dateOnly(date),
    );

    taskList.add(task);
    taskList.refresh();
    // print('task created');
    // print(taskList[0].id);
    // print(taskList[0].taskName);
    // print(taskList[0].startDate);
    // print(taskList.length);
  }

  Future<void> addToList(TaskModel theTask) async {
    taskList.add(theTask);
    taskList.refresh();
  }

  Future<void> deleteTask(int index) async {
    taskList.removeAt(index);
    taskList.refresh();
  }

  Future<void> updateTask(int index, String name) async {
    taskList[index].taskName = name;
    taskList.refresh();
  }

  // TaskController({required this.taskModel});
}
