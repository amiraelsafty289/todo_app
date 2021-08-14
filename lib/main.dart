import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_project/Providers/AppConfigProvider.dart';
import 'package:todo_project/ui/home/DataBase/MyDataBase.dart';
import 'package:todo_project/ui/home/EditToDo/EditToDoItem.dart';
import 'package:todo_project/ui/home/HomeScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  initDateBase();
  runApp(MyApp());
}

class MyThemeData {
  static final primaryColor = Color.fromRGBO(93, 156, 236, 1.0);
  static final blackColor = Color.fromRGBO(54, 54, 54, 1.0);
  static final whiteColor = Color.fromRGBO(255, 255, 255, 1.0);
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
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: MyThemeData.darkThemeColor,
    ),
    scaffoldBackgroundColor: MyThemeData.darkThemeColorBg,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: MyThemeData.primaryColor,
    ),
  );
}

class MyApp extends StatelessWidget {
  AppConfigProvider themeProvider;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppConfigProvider(),
      builder: (context, widget) {
        themeProvider = Provider.of<AppConfigProvider>(context);
        final localProvider = Provider.of<AppConfigProvider>(context);
        getThemeMode();
        getLocalization();
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'To Do App',
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale(localProvider.locale, ''),
          themeMode: themeProvider.themeMode,
          theme: MyThemeData.lightThemeMode,
          darkTheme: MyThemeData.darkThemeMode,
          routes: {
            HomeScreen.ROUTE_NAME: (context) => HomeScreen(),
            EditToDoItem.ROUTE_NAME: (context) => EditToDoItem(),
          },
          initialRoute: HomeScreen.ROUTE_NAME,
        );
      },
    );
  }

  void getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    String themeMode = prefs.getString('theme');
    if (themeMode == 'Light' && themeProvider.isDarkModeEnabled()) {
      themeProvider.toggleTheme();
    } else if (themeMode == 'Dark' && !themeProvider.isDarkModeEnabled()) {
      themeProvider.toggleTheme();
    }
  }

  void getLocalization() async {
    final prefs = await SharedPreferences.getInstance();
    String newLocale = prefs.getString('locale');
    if (newLocale == 'en' && themeProvider.locale == 'ar') {
      themeProvider.changeLocale('en');
    } else if (newLocale == 'ar' && themeProvider.locale == 'en') {
      themeProvider.changeLocale('ar');
    }
  }
}
