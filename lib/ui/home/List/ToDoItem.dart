import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_project/main.dart';

class ToDoItem extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4 , horizontal: 12),
      child: Slidable(
        closeOnScroll: true,
          actionExtentRatio: 0.3,
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
                    color: MyThemeData.primaryColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  width: 4,
                  height: 80,
                ),
                Expanded(
                    child:Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Play basket ball',
                              style: TextStyle(
                                color: MyThemeData.primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.calendar_today_outlined),
                                Text('12/2/2020',textAlign: TextAlign.center,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                ),
                Container(
                  margin: EdgeInsets.all(12),
                  padding: EdgeInsets.symmetric(vertical: 8 , horizontal: 16),
                  decoration: BoxDecoration(
                    color: MyThemeData.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image(
                    image: AssetImage('assets/images/icon_check.png'),
                  ),
                ),
              ],
            ),
          ),
        actionPane: SlidableScrollActionPane(),
        actions: [
          IconSlideAction(
            color: Colors.transparent,
            iconWidget: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: MyThemeData.redColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12) ,
                    bottomLeft: Radius.circular(12),
                ),
              ),
              height: double.infinity,
              width: double.infinity,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.delete , color: MyThemeData.whiteColor,),
                    Text('Delete',
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
    );
  }
}