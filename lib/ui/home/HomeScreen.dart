import 'package:flutter/material.dart';
import 'package:todo_project/ui/home/List/ToDoListFragment.dart';
import 'package:todo_project/ui/home/Settings/SettingsFragment.dart';
import 'package:todo_project/ui/home/addToDo/AddToDoBottomSheet.dart';

class HomeScreen extends StatefulWidget{
  static final String ROUTE_NAME = 'home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0 ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          openAddToDo();
        },
        child: Icon(Icons.add, color: Colors.white,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      appBar: AppBar(
        toolbarHeight: 120,
        title: Text('To Do List'),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        shape: CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          showUnselectedLabels: false,
          showSelectedLabels: false,
          currentIndex: selectedIndex,
          onTap: (int position){
            setState(() {
              selectedIndex = position ;
            });
          }
          ,
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: ImageIcon(
                AssetImage('assets/images/icon_list.png'),
              ),
            ),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('assets/images/icon_settings.png'),
                ),
              label: 'Settings'
            ),
          ],
        ),
      ),
      body: getMainView(),
    );
  }
  Widget getMainView(){
    if(selectedIndex == 0){
      return ToDoListFragment();
    }else{
      return SettingsFragments();
    }
  }
  void openAddToDo(){
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        builder: (builder){
          return  AddToDoBottomSheet();
        }
    );
        }
  }

