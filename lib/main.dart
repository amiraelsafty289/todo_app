import 'package:flutter/material.dart';
import 'package:todo_project/ui/home/HomeScreen.dart';

void main() {
  runApp(MyApp());
}
class MyThemeData{
  static final  primaryColor = Color.fromRGBO(93, 156, 236, 1.0);
  static final  blackColor = Color.fromRGBO(54, 54, 54, 1.0);
  static final  whiteColor = Color.fromRGBO(255, 255, 255, 1.0);
  static final accentColor = Color.fromRGBO(223, 236, 219, 1.0);
  static final redColor = Color.fromRGBO(236, 75, 75, 1.0);

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do App',
      theme: ThemeData(
        primaryColor: MyThemeData.primaryColor,
        accentColor: MyThemeData.accentColor,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: MyThemeData.primaryColor,
        )
      ),
      routes: {
        HomeScreen.ROUTE_NAME : (context)=> HomeScreen(),
      },
      initialRoute: HomeScreen.ROUTE_NAME,

    );
  }
}
