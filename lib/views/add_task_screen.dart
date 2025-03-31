import 'package:flutter/material.dart';
import 'package:flutter_todo_practice_1/controllers/task_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends StatelessWidget {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TaskController taskController = Get.find();

    return Scaffold(
      appBar: AppBar(),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _controller1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.text_fields),
                  label: Text(
                    'Task Name...',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _controller2,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.calendar_today),
                  labelText: "Task Date",
                  labelStyle: TextStyle(color: Colors.grey),
                ),
                readOnly: true, // when true user cannot edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    //get the picked date in the format => 2022-07-04 00:00:00.000
                    String formattedDate = DateFormat(
                      'yyyy-MM-dd',
                    ).format(pickedDate);
                    // format date in required form here we use yyyy-MM-dd that means time is removed
                    // formatted date output using intl package =>  2022-07-04
                    // You can format date as per your need

                    _controller2.text =
                        formattedDate; //set foratted date to TextField value.
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
          DateTime taskDate = DateTime.parse(_controller2.text);
          taskController.createTask(
            _controller1.text,
            taskDate,
          ); // call createTask function
          Get.back();
        },
        label: Text('Save changes'),
      ),
    );
  }
}
