import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_project/Providers/AppConfigProvider.dart';
import 'package:todo_project/main.dart';
import 'package:todo_project/ui/home/List/ToDoListFragment.dart';
import 'package:todo_project/ui/home/Settings/SettingsFragment.dart';
import 'package:todo_project/ui/home/addToDo/AddToDoBottomSheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static final String ROUTE_NAME = 'home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openAddToDo();
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        toolbarHeight: 120,
        title: Text(
          AppLocalizations.of(context).appTitle,
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: themeProvider.isDarkModeEnabled()
                  ? MyThemeData.blackColor
                  : MyThemeData.whiteColor),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        shape: CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          backgroundColor: themeProvider.isDarkModeEnabled()
              ? MyThemeData.darkThemeColor
              : MyThemeData.whiteColor,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          currentIndex: selectedIndex,
          selectedItemColor: themeProvider.isDarkModeEnabled()
              ? MyThemeData.primaryColor
              : MyThemeData.primaryColor,
          unselectedItemColor: themeProvider.isDarkModeEnabled()
              ? MyThemeData.whiteColor
              : MyThemeData.darkBlackColor,
          onTap: (int position) {
            setState(() {
              selectedIndex = position;
            });
          },
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
                label: 'Settings'),
          ],
        ),
      ),
      body: getMainView(),
    );
  }

  Widget getMainView() {
    if (selectedIndex == 0) {
      return ToDoListFragment();
    } else {
      return SettingsFragments();
    }
  }

  void openAddToDo() {
    // final themeProvider1 = Provider.of<ThemeProvider>(context);
    showModalBottomSheet(
        context: context,
        // backgroundColor: themeProvider1.isDarkModeEnabled()?MyThemeData.darkThemeColor:MyThemeData.whiteColor ,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        builder: (builder) {
          return AddToDoBottomSheet();
        });
  }
}
