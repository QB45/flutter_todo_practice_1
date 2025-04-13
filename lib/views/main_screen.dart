import 'package:flutter/material.dart';
import 'package:flutter_todo_practice_1/components/my_styles.dart';
import 'package:flutter_todo_practice_1/controllers/task_controller.dart';
import 'package:flutter_todo_practice_1/main.dart';
import 'package:flutter_todo_practice_1/models/task_model.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../components/hive_data.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  // Initialize TaskController once
  final TaskController taskController = Get.put(TaskController());

  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();

  final theBox = Hive.box<TaskHive>(taskBoxName);

  String text1 = '', text2 = '';
  final int index = 0;
  bool isEdit = false;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (theBox.isNotEmpty) {
      for (int i = 0; i < theBox.length; i++) {
        taskController.taskList.add(
          TaskModel(id: i, taskName: theBox.getAt(i)!.name, startDate: theBox.getAt(i)!.date),
        );
      }
    }

    return Scaffold(
      key: _scaffoldKey,
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
                  child: Center(child: Text("Add New Task", style: TextStyle(fontSize: 20))),
                ),
              ),
              onTap: () {
                isEdit = false;
                String text1 = '', text2 = '';
                int index = 0;
                taskBottomSheet(text1, text2, index);
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
                                style: TextStyle(fontSize: 20, color: Colors.grey),
                              ),
                            )
                            : ListView.builder(
                              itemCount: taskController.taskList.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: ((context, index) {
                                return Padding(
                                  padding:
                                      (index == 0)
                                          ? const EdgeInsets.fromLTRB(8, 8, 8, 8)
                                          : const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                  child: Container(
                                    height: 60,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  taskController.taskList[index].taskName,
                                                  style: TextStyle(fontSize: 18),
                                                ),
                                                Text(
                                                  'Date to Do: ${DateFormat('yyyy-MM-dd').format(taskController.taskList[index].startDate)}',
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              isEdit = true;
                                              text1 = taskController.taskList[index].taskName;
                                              text2 = DateFormat(
                                                'yyyy-MM-dd',
                                              ).format(taskController.taskList[index].startDate);
                                              taskBottomSheet(text1, text2, index);
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

  Future<PersistentBottomSheetController?> taskBottomSheet(
    String text1,
    String text2,
    int index,
  ) async {
    return _scaffoldKey.currentState?.showBottomSheet(
      backgroundColor: Colors.amber,
      enableDrag: true,
      showDragHandle: true,
      (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 48, 16),
              child: Column(
                children: [
                  TextFormField(
                    controller:
                        !isEdit ? controller1 : controller1
                          ..text = text1,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(),
                      icon: const Icon(Icons.text_fields),
                      label: Text('Task Name', style: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller:
                        !isEdit ? controller2 : controller2
                          ..text = text2,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(),
                      icon: const Icon(Icons.calendar_today),
                      labelText: 'Task Date',
                      labelStyle: const TextStyle(color: Colors.grey),
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: isEdit ? DateTime.parse(text2) : DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        // DateFormat() ... [using intl package]
                        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                        controller2.text = formattedDate;
                      }
                    },
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: myButtonStyle,
                          onPressed: () {
                            if (controller1.text == '' || controller2.text == '') {
                              snackMsg(context, 'Fields may not be empty');
                            } else {
                              DateTime taskDate = DateTime.parse(controller2.text);

                              if (isEdit) {
                                // call updateTask function
                                taskController.updateTask(index, controller1.text, taskDate);
                                final theTask = TaskHive();
                                theTask.name = controller1.text;
                                theTask.date = taskDate;
                                theBox.putAt(index, theTask);
                              } else {
                                // call createTask function
                                taskController.createTask(controller1.text, taskDate);
                                final theTask = TaskHive();
                                theTask.name = controller1.text;
                                theTask.date = taskDate;
                                theBox.add(theTask);
                              }

                              Get.back();
                              // Navigator.pop(context);
                              // Navigator.of(context).pop();
                            }
                          },
                          child: Text('Save'),
                        ),

                        ElevatedButton(
                          style: myButtonStyle,
                          onPressed: () => Get.back(),
                          child: Text('Cancel'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

void snackMsg(BuildContext context, String myMessage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(milliseconds: 2000),
      backgroundColor: Colors.lightGreen,
      content: Center(child: Text(myMessage, style: Theme.of(context).textTheme.titleLarge)),
    ),
  );
}
