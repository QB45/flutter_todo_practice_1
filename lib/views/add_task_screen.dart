import 'package:flutter/material.dart';
import 'package:flutter_todo_practice_1/controllers/task_controller.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../components/hive_data.dart';
import '../main.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  get theBox => Hive.box<TaskHive>(taskBoxName);

  @override
  Widget build(BuildContext context) {
    TaskController taskController = Get.find();
    final TextEditingController controller1 = TextEditingController();
    final TextEditingController controller2 = TextEditingController();

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
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    // DateFormat() ... [using intl package]
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
          // call createTask function
          taskController.createTask(controller1.text, taskDate);
          final theTask = TaskHive();
          theTask.name = controller1.text;
          theTask.date = taskDate;
          theBox.add(theTask);
          Get.back();
        },
        label: Text('Save changes'),
      ),
    );
  }
}
