import 'package:flutter/material.dart';
import 'package:flutter_todo_practice_1/controllers/task_controller.dart';
import 'package:flutter_todo_practice_1/main.dart';
import 'package:flutter_todo_practice_1/models/task_model.dart';
import 'package:flutter_todo_practice_1/views/add_task_screen.dart';
import 'package:flutter_todo_practice_1/views/edit_task_screen.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../components/hive_data.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  // Initialize TaskController once
  final TaskController taskController = Get.put(TaskController());

  final theBox = Hive.box<TaskHive>(taskBoxName);

  @override
  Widget build(Object context) {
    if (theBox.isNotEmpty) {
      for (int i = 0; i < theBox.length; i++) {
        taskController.taskList.add(
          TaskModel(
            id: i,
            taskName: theBox.getAt(i)!.name,
            startDate: theBox.getAt(i)!.date,
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            InkWell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text("Add New Task", style: TextStyle(fontSize: 20)),
                  ),
                ),
              ),
              onTap: () {
                Get.to(() => AddTaskScreen()); // or Get.to(AddTaskScreen());
              },
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GetX<TaskController>(
                init: TaskController(),
                initState: (_) {},
                builder: (_) {
                  return Container(
                    height: 350,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child:
                        taskController.taskList.isEmpty
                            ? Center(
                              child: Text(
                                'No Task Found',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                            : ListView.builder(
                              itemCount: taskController.taskList.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: ((context, index) {
                                return Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    8,
                                    8,
                                    8,
                                    0,
                                  ),
                                  child: Container(
                                    height: 60,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  taskController
                                                      .taskList[index]
                                                      .taskName,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Text(
                                                  'Date to Do: ${DateFormat('yyyy-MM-dd').format(taskController.taskList[index].startDate)}',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              // goto editTask screen
                                              Get.to(
                                                () => EditTaskScreen(
                                                  index: index,
                                                ),
                                              );
                                            },
                                            child: Icon(Icons.edit),
                                          ),
                                          SizedBox(width: 10),
                                          InkWell(
                                            onTap: () {
                                              // call deleteTask function
                                              taskController.deleteTask(index);
                                              theBox.deleteAt(index);
                                            },
                                            child: Icon(Icons.delete),
                                          ),
                                          SizedBox(width: 10),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
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
