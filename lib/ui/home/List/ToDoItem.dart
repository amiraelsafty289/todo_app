import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_project/main.dart';
import 'package:todo_project/ui/home/DataBase/Model/ToDo.dart';

class ToDoItem extends StatelessWidget {
  ToDo todo;
  Function onDeleteAction;
  Function onItemCheck;
  Function onItemPressed;
  ToDoItem(
      {this.todo, this.onDeleteAction, this.onItemCheck, this.onItemPressed});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onItemPressed(todo, context);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        child: Slidable(
          closeOnScroll: true,
          actionExtentRatio: 0.3,
          child: InkWell(
            child: Container(
              decoration: BoxDecoration(
                color: MyThemeData.whiteColor,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: todo.isDone
                          ? MyThemeData.greenColor
                          : MyThemeData.primaryColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    width: 4,
                    height: 80,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              todo.title,
                              style: TextStyle(
                                  color: todo.isDone
                                      ? MyThemeData.greenColor
                                      : MyThemeData.primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.calendar_today_outlined),
                                Text(
                                  '${todo.dateTime.day}/${todo.dateTime.month}/${todo.dateTime.year}'
                                      .toString(),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      onItemCheck(todo);
                    },
                    child: todo.isDone
                        ? Container(
                            margin: EdgeInsets.all(12),
                            child: Text(
                              'Done!',
                              style: TextStyle(
                                  color: MyThemeData.greenColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.all(12),
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                              color: MyThemeData.primaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image(
                              image: AssetImage('assets/images/icon_check.png'),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
          actionPane: SlidableScrollActionPane(),
          actions: [
            IconSlideAction(
              onTap: () {
                onDeleteAction(todo);
              },
              color: Colors.transparent,
              iconWidget: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: MyThemeData.redColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                height: double.infinity,
                width: double.infinity,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.delete,
                        color: MyThemeData.whiteColor,
                      ),
                      Text(
                        'Delete',
                        style: TextStyle(
                          color: MyThemeData.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
