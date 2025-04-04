import 'package:flutter/material.dart';
import 'views/main_screen.dart';
import 'package:get/get.dart';

const taskDB = 'taskDataBase';

Future<void> main() async {
  runApp(const ToDoPractice());
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
