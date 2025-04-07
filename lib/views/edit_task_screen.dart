import 'package:flutter/material.dart';
import 'package:flutter_todo_practice_1/controllers/task_controller.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import '../components/hive_data.dart';
import '../main.dart';

class EditTaskScreen extends StatelessWidget {
  int index;

  EditTaskScreen({super.key, required this.index});

  get theBox => Hive.box<TaskHive>(taskBoxName);

  @override
  Widget build(BuildContext context) {
    TaskController taskController = Get.find();
    final TextEditingController controller1 =
        TextEditingController()..text = taskController.taskList[index].taskName;
    final TextEditingController controller2 =
        TextEditingController()
          ..text = DateFormat(
            'yyyy-MM-dd',
          ).format(taskController.taskList[index].startDate);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: controller1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.text_fields),
                  label: Text(
                    'Task Name',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: controller2,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.calendar_today),
                  labelText: 'Task Date',
                  labelStyle: TextStyle(color: Colors.grey),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: taskController.taskList[index].startDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    String formattedDate = DateFormat(
                      'yyyy-MM-dd',
                    ).format(pickedDate);
                    controller2.text = formattedDate;
                  }
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          DateTime taskDate = DateTime.parse(controller2.text);
          // call updateTask function
          taskController.updateTask(index, controller1.text, taskDate);
          final theTask = TaskHive();
          theTask.name = controller1.text;
          theTask.date = taskDate;
          theBox.putAt(index, theTask);
          Get.back();
        },
        label: Text('Save changes'),
      ),
    );
  }
}
