import 'package:flutter/material.dart';
import 'package:flutter_todo_practice_1/controllers/task_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditTaskScreen extends StatelessWidget {
  var index;

  EditTaskScreen({super.key, required this.index});

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
                // readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
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
          taskController.updateTask(
            index,
            controller1.text,
            taskDate,
          ); // call createTask function
          Get.back();
        },
        label: Text('Save changes'),
      ),
    );
  }
}
