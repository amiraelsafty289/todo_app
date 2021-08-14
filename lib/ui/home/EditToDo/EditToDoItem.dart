import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:todo_project/Providers/AppConfigProvider.dart';
import 'package:todo_project/main.dart';
import 'package:todo_project/ui/home/DataBase/Model/ToDo.dart';

class EditToDoItem extends StatefulWidget {
  static final ROUTE_NAME = 'Edit';

  @override
  _EditToDoItemState createState() => _EditToDoItemState();
}

class _EditToDoItemState extends State<EditToDoItem> {
  ToDo todo;
  String title;
  String content;
  DateTime date;
  int buildTimeCounter = 0;
  bool titleError = false;
  bool contentError = false;
  bool dateError = false;
  int index;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppConfigProvider>(context);
    if (buildTimeCounter == 0) {
      Map<String, Object> map = ModalRoute.of(context).settings.arguments;
      ;
      todo = map['todo'];
      index = map['index'];
      if (todo != null) {
        title = todo.title;
        content = todo.content;
        date = todo.dateTime;
        buildTimeCounter++;
      }
    }
    return Scaffold(
      backgroundColor: themeProvider.isDarkModeEnabled()
          ? MyThemeData.darkThemeColorBg
          : MyThemeData.accentColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                color: MyThemeData.primaryColor,
                padding: EdgeInsets.only(bottom: 120),
                child: AppBar(
                  elevation: 0,
                  title: Text(
                    'To Do List',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.isDarkModeEnabled()
                            ? MyThemeData.blackColor
                            : MyThemeData.whiteColor),
                  ),
                  backgroundColor: MyThemeData.primaryColor,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(18),
              margin:
                  EdgeInsets.only(top: 100, bottom: 18, left: 18, right: 18),
              width: 365,
              height: 588,
              decoration: BoxDecoration(
                color: themeProvider.isDarkModeEnabled()
                    ? MyThemeData.darkThemeColor
                    : MyThemeData.whiteColor,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Edit Task',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.isDarkModeEnabled()
                          ? MyThemeData.whiteColor
                          : MyThemeData.darkBlackColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    style: TextStyle(
                      color: themeProvider.isDarkModeEnabled()
                          ? MyThemeData.whiteColor
                          : MyThemeData.darkBlackColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    initialValue: title,
                    onChanged: (newText) {
                      if (!newText.isEmpty) {
                        setState(() {
                          titleError = false;
                        });
                      }
                      title = newText;
                    },
                    decoration: InputDecoration(
                      hintText: 'This is Title',
                      hintStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.isDarkModeEnabled()
                            ? MyThemeData.whiteColor
                            : MyThemeData.darkBlackColor,
                      ),
                      errorText:
                          titleError ? 'Please enter a valid title' : null,
                      errorStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    style: TextStyle(
                      color: themeProvider.isDarkModeEnabled()
                          ? MyThemeData.whiteColor
                          : MyThemeData.darkBlackColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    initialValue: content,
                    onChanged: (newText) {
                      if (!newText.isEmpty) {
                        setState(() {
                          contentError = false;
                        });
                      }
                      content = newText;
                    },
                    maxLines: 2,
                    minLines: 2,
                    decoration: InputDecoration(
                      hintText: 'Task Details',
                      hintStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.isDarkModeEnabled()
                            ? MyThemeData.whiteColor
                            : MyThemeData.darkBlackColor,
                      ),
                      errorText:
                          contentError ? 'Please enter a valid content' : null,
                      errorStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      chooseDateForToDo();
                    },
                    child: date == null
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 5),
                            child: Text(
                              'Select Time',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: dateError
                                    ? MyThemeData.redColor
                                    : MyThemeData.blackColor,
                              ),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 5),
                            child: Text(
                              '${date.day}/${date.month}/${date.year}'
                                  .toString(),
                              style: TextStyle(
                                color: MyThemeData.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 140,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      editToDoItem(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          MyThemeData.primaryColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        'Save Changes',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: MyThemeData.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool validation() {
    bool valid = true;
    if (title.isEmpty) {
      setState(() {
        titleError = true;
        valid = false;
      });
    }
    if (content.isEmpty) {
      setState(() {
        contentError = true;
        valid = false;
      });
    }
    if (date == null) {
      setState(() {
        dateError = true;
        valid = false;
      });
    }
    return valid;
  }

  void editToDoItem(BuildContext context) async {
    if (!validation()) return;
    var box = await Hive.openBox<ToDo>(ToDo.BOX_NAME);
    box.putAt(
        index,
        ToDo(
            title: title,
            content: content,
            dateTime: date,
            isDone: todo.isDone));
    Navigator.pop(context);
  }

  void chooseDateForToDo() async {
    var choosenDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(days: 365),
      ),
    );
    setState(() {
      date = choosenDate;
      if (date != null) {
        dateError = false;
      }
    });
  }
}
