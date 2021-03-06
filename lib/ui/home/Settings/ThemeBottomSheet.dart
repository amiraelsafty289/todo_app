import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_project/Providers/AppConfigProvider.dart';
import 'package:todo_project/main.dart';

class ThemeBottomSheet extends StatelessWidget {
  AppConfigProvider themeProvider;
  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<AppConfigProvider>(context);
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(15),
      child: Column(
        children: [
          InkWell(
              onTap: () {
                if (themeProvider.isDarkModeEnabled()) {
                  themeProvider.toggleTheme();
                  saveTheme('Light');
                  Navigator.pop(context);
                }
              },
              child: getRow('Light', !themeProvider.isDarkModeEnabled())),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              if (!themeProvider.isDarkModeEnabled()) {
                themeProvider.toggleTheme();
                saveTheme('Dark');
                Navigator.pop(context);
              }
            },
            child: getRow('Dark', themeProvider.isDarkModeEnabled()),
          ),
        ],
      ),
    );
  }

  Widget getRow(String text, bool isSelected) {
    if (isSelected) {
      return Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: MyThemeData.primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Icon(
            Icons.check,
            color: MyThemeData.primaryColor,
            size: 24,
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: themeProvider.isDarkModeEnabled()
                      ? MyThemeData.whiteColor
                      : MyThemeData.blackColor),
            ),
          ),
        ],
      );
    }
  }

  void saveTheme(String newTheme) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', newTheme);
  }
}
