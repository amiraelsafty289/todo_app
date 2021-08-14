import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_project/Providers/AddToDoProvider.dart';
import 'package:todo_project/Providers/AppConfigProvider.dart';
import 'package:todo_project/main.dart';
import 'package:todo_project/ui/home/DataBase/Model/ToDo.dart';
import 'package:todo_project/ui/home/EditToDo/EditToDoItem.dart';
import 'package:todo_project/ui/home/List/ToDoItem.dart';

class ToDoListFragment extends StatefulWidget {
  static final String ROUTE_NAME = 'list';

  @override
  _ToDoListFragmentState createState() => _ToDoListFragmentState();
}

class _ToDoListFragmentState extends State<ToDoListFragment> {
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  AddToDoProvider todoListProvider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddToDoProvider(),
      builder: (context, widget) {
        final themeProvider = Provider.of<AppConfigProvider>(context);
        todoListProvider = Provider.of<AddToDoProvider>(context);
        getAllTodoFromBox();
        return Container(
          child: Column(
            children: [
              TableCalendar(
                headerStyle: HeaderStyle(
                    decoration: BoxDecoration(
                  color: themeProvider.isDarkModeEnabled()
                      ? MyThemeData.darkThemeColor
                      : MyThemeData.whiteColor,
                )),
                weekendDays: [],
                focusedDay: DateTime.now(),
                firstDay: DateTime.now().subtract(
                  Duration(days: 30),
                ),
                lastDay: DateTime.now().add(
                  Duration(days: 30),
                ),
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
                daysOfWeekStyle: DaysOfWeekStyle(
                  decoration: BoxDecoration(
                    color: MyThemeData.whiteColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                selectedDayPredicate: (day) {
                  return isSameDay(day, selectedDay);
                },
                onDaySelected: (newSelectedDay, newFocusedDay) {
                  setState(() {
                    selectedDay = newSelectedDay;
                    focusedDay = newFocusedDay;
                  });
                  getAllTodoFromBox();
                },
              ),
              Expanded(
                child: todoListProvider.todoList.length > 0
                    ? ListView.builder(
                        itemBuilder: (context, index) {
                          return ToDoItem(
                            todo: todoListProvider.todoList[index],
                            onDeleteAction: onDeleteTask,
                            onItemCheck: onItemChecked,
                            onItemPressed: onEditItemPressed,
                            index: index,
                          );
                        },
                        itemCount: todoListProvider.todoList.length,
                      )
                    : Center(
                        child: Text(
                          'No ToDos For this days',
                          style: TextStyle(
                            color: themeProvider.isDarkModeEnabled()
                                ? MyThemeData.whiteColor
                                : MyThemeData.blackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  void onEditItemPressed(ToDo item, BuildContext context, int index) async {
    var box = await Hive.openBox<ToDo>(ToDo.BOX_NAME);
    List<ToDo> list = box.values.toList();
    int newIndex = 0;
    newIndex = list.indexOf(item);
    index = list.indexOf(item);
    box.close();
    Navigator.of(context).pushNamed(EditToDoItem.ROUTE_NAME,
        arguments: {'todo': item, 'index': newIndex});
  }

  void onItemChecked(ToDo item) async {
    var box = await Hive.openBox<ToDo>(ToDo.BOX_NAME);
    int index = box.values.toList().indexOf(item);
    item.isDone = item.isDone ? false : true;
    box.putAt(index, item);
    getAllTodoFromBox();
  }

  void onDeleteTask(ToDo item) async {
    var box = await Hive.openBox<ToDo>(ToDo.BOX_NAME);
    int index = box.values.toList().indexOf(item);
    box.deleteAt(index);
    getAllTodoFromBox();
  }

  void getAllTodoFromBox() async {
    var box = await Hive.openBox<ToDo>(ToDo.BOX_NAME);
    setState(() {
      List<ToDo> toDoList = box.values
          .where((item) => isSameDay(item.dateTime, selectedDay))
          .toList();
      todoListProvider.updateList(toDoList);
    });
  }
}
