import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_project/main.dart';
import 'package:todo_project/ui/home/List/ToDoItem.dart';

class ToDoListFragment extends StatefulWidget{
  static final String ROUTE_NAME = 'list';

  @override
  _ToDoListFragmentState createState() => _ToDoListFragmentState();
}

class _ToDoListFragmentState extends State<ToDoListFragment> {
  DateTime selectedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyThemeData.accentColor,
      child: Column(
        children: [
          TableCalendar(
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
            onDaySelected: (newSelectedDay,focusedDay){
                setState(() {
                  selectedDay = newSelectedDay;
                });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context , index){
                return ToDoItem();
              },
                itemCount: 5,
            ),
          ),
        ],
      ),
    );
  }
}