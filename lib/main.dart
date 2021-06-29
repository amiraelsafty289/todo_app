import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_project/Providers/ThemeProvider.dart';
import 'package:todo_project/ui/home/DataBase/MyDataBase.dart';
import 'package:todo_project/ui/home/EditToDo/EditToDoItem.dart';
import 'package:todo_project/ui/home/HomeScreen.dart';

void main() {
  initDateBase();
  runApp(MyApp());
}
class MyThemeData{
  static final  primaryColor = Color.fromRGBO(93, 156, 236, 1.0);
  static final  blackColor = Color.fromRGBO(54, 54, 54, 1.0);
  static final  whiteColor = Color.fromRGBO(255, 255, 255, 1.0);
  static final accentColor = Color.fromRGBO(223, 236, 219, 1.0);
  static final redColor = Color.fromRGBO(236, 75, 75, 1.0);
  static final greenColor = Color.fromRGBO(97, 231, 87, 1.0);
  static final darkBlackColor = Color.fromRGBO(56, 56, 56, 1.0);
  static final darkThemeColorBg = Color.fromRGBO(6, 14, 30, 1.0);
  static final darkThemeColor = Color.fromRGBO(20, 25, 34, 1.0);

  static final lightThemeMode = ThemeData(
      primaryColor: MyThemeData.primaryColor,
      accentColor: MyThemeData.accentColor,
      scaffoldBackgroundColor: MyThemeData.accentColor,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: MyThemeData.primaryColor,
      ),
  );

  static final darkThemeMode = ThemeData(
      primaryColor: MyThemeData.primaryColor,
      accentColor: MyThemeData.darkThemeColor,
      scaffoldBackgroundColor: MyThemeData.darkThemeColorBg,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: MyThemeData.primaryColor,
      ),
  );

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> ThemeProvider(),
      builder: (context , widget){
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'To Do App',
          themeMode: themeProvider.themeMode,
          theme: MyThemeData.lightThemeMode,
          darkTheme: MyThemeData.darkThemeMode,
          routes: {
            HomeScreen.ROUTE_NAME : (context)=> HomeScreen(),
            EditToDoItem.ROUTE_NAME : (context)=> EditToDoItem(),
          },
          initialRoute: HomeScreen.ROUTE_NAME,

        );
      },
    );
  }
}
