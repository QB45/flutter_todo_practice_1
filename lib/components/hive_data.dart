import 'package:hive_flutter/hive_flutter.dart';
part 'hive_data.g.dart';

@HiveType(typeId: 0)
class TaskHive extends HiveObject {
  @HiveField(1)
  String name = '';
  @HiveField(2)
  DateTime date = DateTime.now();
}
