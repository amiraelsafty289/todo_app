import 'package:flutter/material.dart';
import 'package:todo_project/ui/home/DataBase/Model/ToDo.dart';

class AddToDoProvider extends ChangeNotifier {
  List<ToDo> todoList = [];

  void updateList(List<ToDo> newTodoList) {
    todoList = newTodoList;
    notifyListeners();
  }
}
