import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'components/hive_data.dart';
import 'views/main_screen.dart';
import 'package:get/get.dart';

const taskBoxName = 'taskDataBase';
const sortBoxName = 'sortDataBase';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskHiveAdapter());

  if (!kIsWeb) {
    // not running on the web!
    final Directory tempDir = await getTemporaryDirectory();
    Hive.init(tempDir.path);
  } else {
    // running on the web!
  }

  await Hive.openBox<TaskHive>(taskBoxName);
  await Hive.openBox(sortBoxName);

  runApp(const ToDoPractice());
}

class ToDoPractice extends StatelessWidget {
  const ToDoPractice({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Task Manager Practice",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainScreen(),
    );
  }
}
