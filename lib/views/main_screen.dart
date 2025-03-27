import 'package:flutter/material.dart';
import 'package:flutter_todo_practice_1/components/fake_data.dart';
import 'package:flutter_todo_practice_1/controllers/task_controller.dart';
import 'package:flutter_todo_practice_1/models/task_model.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final title1 = "new task".obs;
  final h1 = 50.0.obs;
  // Initialize TaskController once
  final TaskController taskController = Get.put(
    TaskController(
      taskModel:
          TaskModel(
            id: 1,
            taskName: "First Task",
            startDate: DateTime.now(),
            endDate: DateTime.now(),
          ).obs,
    ),
  );
  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            InkWell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () => Container(
                    height: h1.value,
                    width: double.infinity,
                    color: Colors.amber,
                    child: Center(child: Text(title1.value)),
                  ),
                ),
              ),
              onTap: () {
                title1.value = "old task";
                h1.value = 80;
              },
            ),
            SizedBox(
              height: 230,
              child: GetX<TaskController>(
                // Use the existing TaskController instance
                builder: (controller) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 90,
                          width: double.infinity,
                          color: Colors.cyanAccent,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        taskList[1].taskName,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        controller.taskModel.value.taskName,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Text(
                                        'Start Time: ${controller.taskModel.value.startDate}',
                                        style: TextStyle(fontSize: 10.5),
                                      ),
                                      Text(
                                        'End Time: ${controller.taskModel.value.endDate}',
                                        style: TextStyle(fontSize: 10.5),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.setTask();
                                  },
                                  child: Icon(Icons.edit),
                                ),
                                SizedBox(width: 10),
                                InkWell(
                                  onTap: () {
                                    // Remove task logic here
                                  },
                                  child: Icon(Icons.delete),
                                ),
                                SizedBox(width: 10),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
