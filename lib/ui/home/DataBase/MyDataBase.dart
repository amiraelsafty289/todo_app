import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_project/ui/home/DataBase/Model/ToDo.dart';

void initDateBase() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoAdapter());
}
