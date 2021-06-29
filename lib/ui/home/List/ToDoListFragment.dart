import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_project/main.dart';
import 'package:todo_project/ui/home/DataBase/Model/ToDo.dart';
import 'package:todo_project/ui/home/EditToDo/EditToDoItem.dart';
import 'package:todo_project/ui/home/List/ToDoItem.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ToDoListFragment extends StatefulWidget{
  static final String ROUTE_NAME = 'list';

  @override
  _ToDoListFragmentState createState() => _ToDoListFragmentState();
}

class _ToDoListFragmentState extends State<ToDoListFragment> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  List<ToDo> toDoList = [];


  @override
  void initState() {
    super.initState();
    getAllTodoFromBox();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('ToDoList Screen'),
      onVisibilityChanged: (visibilityInfo) {
       getAllTodoFromBox();
      },
      child:Container(
        // color: MyThemeData.accentColor,
        child: Column(
          children: [
            TableCalendar(
              weekendDays: [],
                focusedDay:DateTime.now(),
                firstDay: DateTime.now().subtract(Duration(days: 30),) ,
                lastDay: DateTime.now().add(Duration(days: 30),),
              calendarFormat: CalendarFormat.week,
              headerVisible: false,
              calendarStyle: CalendarStyle(
                selectedTextStyle: TextStyle(
                  fontSize: 16,
                  color: MyThemeData.whiteColor,
                ),
                selectedDecoration: BoxDecoration(
                  color: MyThemeData.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                defaultDecoration: BoxDecoration(
                  color: MyThemeData.whiteColor,
                  borderRadius: BorderRadius.circular(8),
                ),

                defaultTextStyle: TextStyle(
                  fontSize: 16,
                  color: MyThemeData.blackColor,
                ),
                isTodayHighlighted: false,
              ),
              daysOfWeekStyle:DaysOfWeekStyle(
                decoration: BoxDecoration(
                  color: MyThemeData.whiteColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ) ,

              selectedDayPredicate: (day){
                 return isSameDay(day , selectedDay);
              },
              onDaySelected: (newSelectedDay,newFocusedDay){
                  setState(() {
                    selectedDay = newSelectedDay;
                    focusedDay = newFocusedDay;
                  });
                  getAllTodoFromBox();
              },
            ),
            Expanded(
              child: toDoList.length>0 ?
              ListView.builder(
                itemBuilder: (context , index){
                  return ToDoItem(todo: toDoList[index],onDeleteAction: onDeleteTask, onItemCheck: onItemChecked ,onItemPressed: onEditItemPressed,);
                },
                  itemCount: toDoList.length,
              ):
                  Center(
                    child: Text('No ToDos For this days'),
                  ),

            ),
          ],
        ),
      ),

    );
  }
  void onEditItemPressed(ToDo item , BuildContext context) async{
    var box = await Hive.openBox<ToDo>(ToDo.BOX_NAME);
    box.close();
    Navigator.of(context).pushNamed(EditToDoItem.ROUTE_NAME, arguments: item);
  }
  void onItemChecked(ToDo item)async{
     var box = await Hive.openBox<ToDo>(ToDo.BOX_NAME);
     int index = box.values.toList().indexOf(item);
     item.isDone = item.isDone ? false : true ;
     box.putAt(index, item);
     getAllTodoFromBox();
  }
  void onDeleteTask(ToDo item) async{
    var box = await Hive.openBox<ToDo>(ToDo.BOX_NAME);
    int index = box.values.toList().indexOf(item);
    box.deleteAt(index);
    getAllTodoFromBox();
  }
  void getAllTodoFromBox() async{
    var box = await Hive.openBox<ToDo>(ToDo.BOX_NAME);
    setState(() {
      toDoList = box.values.where((item) => isSameDay(item.dateTime, selectedDay)).toList();
    });
  }
}