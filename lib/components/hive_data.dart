import 'package:hive_flutter/hive_flutter.dart';
part 'hive_data.g.dart';

@HiveType(typeId: 0)
class TaskHive extends HiveObject {
  @HiveField(1)
  String name = '';
  @HiveField(2)
  DateTime date = DateTime.now();
  @HiveField(3)
  bool highPriority = false;
}

// @HiveType(typeId: 1)
//   @HiveField(0)
//   int sortBy = 1;
//   @HiveField(1)
//   int sortMode = 1;
