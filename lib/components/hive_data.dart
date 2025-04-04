import 'package:hive/hive.dart';
part 'hive_data.g.dart';

@HiveType(typeId: 0)
class TaskHive extends HiveObject {
  @HiveField(0)
  int id = 0;
  @HiveField(1)
  String name = '';
  @HiveField(2)
  DateTime date = DateTime.now();
}
