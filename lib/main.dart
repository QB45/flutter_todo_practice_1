import 'package:flutter/material.dart';
import 'package:flutter_todo_practice_1/views/main_screen.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

Future<void> main() async {
  await Hive.initflutter();
  runApp(const ToDoPractice());
}

extension on HiveInterface {
  initflutter() {}
}

class ToDoPractice extends StatelessWidget {
  const ToDoPractice({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Task Manager Practice",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainScreen(),
    );
  }
}

// Future<void> pickDate() async {
//   final DateTime? pickedDate = await showDatePicker(
//     context: context,
//     initialDate: DateTime.now(), // Current date
//     firstDate: DateTime(2000), // Earliest date
//     lastDate: DateTime(2101), // Latest date
//   );

//   if (pickedDate != null && pickedDate != selectedDate) {
//     setState(() {
//       selectedDate = pickedDate;
//     });
//   }
// }
