import 'package:hive/hive.dart';
part 'ToDo.g.dart';

@HiveType(typeId: 0)
class ToDo extends HiveObject {
  // Model Class represent data
  static final BOX_NAME  ='todos';

  @HiveField(0)
  String title;

  @HiveField(1)
  String content;

  @HiveField(2)
  DateTime dateTime;

  @HiveField(3)
  bool isDone;
  
  ToDo({this.title,this.content,this.dateTime,this.isDone = false});
}
