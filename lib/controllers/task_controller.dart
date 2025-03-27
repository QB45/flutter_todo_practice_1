import 'package:flutter_todo_practice_1/models/task_model.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  var taskModel =
      TaskModel(
        id: 1,
        taskName: "First Task",
        startDate: DateTime.now(),
        endDate: DateTime.now(),
      ).obs;
  TaskController({required this.taskModel});
  void setTask() {
    // Update the existing taskModel instead of creating a new one
    taskModel.value = TaskModel(
      id: 2,
      taskName: "Second Task",
      startDate: DateTime.now(),
      endDate: DateTime.now(),
    );

    // Call update only once after modifying taskModel
    update();
    print("Task updated to Second Task"); // Optional for debugging
  }
}
