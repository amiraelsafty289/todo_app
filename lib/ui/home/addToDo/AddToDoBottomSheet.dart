import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_project/main.dart';
import 'package:todo_project/ui/home/DataBase/Model/ToDo.dart';

class AddToDoBottomSheet extends StatefulWidget {
  @override
  _AddToDoBottomSheetState createState() => _AddToDoBottomSheetState();
}

class _AddToDoBottomSheetState extends State<AddToDoBottomSheet> {
  String title = '';
  String content = '';
  DateTime date = null;
  bool titleError = false ;
  bool contentError = false ;
  bool dateError = false ;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Add New Task',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          TextField(
            onChanged: (newText) {
              if(!newText.isEmpty){
                setState(() {
                  titleError = false ;
                });
              }
              title = newText ;
            },
            decoration: InputDecoration(
              labelText: 'Title',
              errorText: titleError ? 'Please enter a valid title' : null ,
              errorStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15 ,
              ),
            ),
          ),
          TextField(
            onChanged: (newText) {
              if(!newText.isEmpty) {
                setState(() {
                  contentError = false;
                });
              }
              content = newText ;
            },
            maxLines: 4,
            minLines: 4,
            decoration: InputDecoration(
              labelText: 'Content',
              errorText: contentError ? 'Please enter a valid content' : null ,
              errorStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15 ,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              chooseDateForToDo();
            },
            child: date == null
                ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 5),
                    child: Text(
                      'Select Date',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: dateError ? MyThemeData.redColor : MyThemeData.blackColor,
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 5),
                    child: Text('${date.day}/${date.month}/${date.year}'.toString(),
                      style: TextStyle(
                        color: MyThemeData.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
          ),

          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(MyThemeData.primaryColor),
            ),
            onPressed: (){
              addToDoItem();
            },
            child: Text(
              'Add',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: MyThemeData.whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
  void addToDoItem() async{
    if(!validation()) return ;
    ToDo todo = ToDo(title: title , content: content , dateTime: date );
    var box = await Hive.openBox<ToDo>(ToDo.BOX_NAME);
    box.add(todo);
    Navigator.pop(context);
    setState(() {
      print('add to do item');
    });
  }
  bool validation(){
    bool valid = true ;
    if(title.isEmpty){
      setState(() {
        titleError = true ;
        valid = false ;
      });
    }if(content.isEmpty){
      setState(() {
        contentError = true ;
        valid = false ;
      });
    }if(date == null){
      setState(() {
        dateError = true ;
        valid = false ;
      });
    }
    return valid ;
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
      if(date != null){
        dateError = false ;
      }
    });
  }
}
