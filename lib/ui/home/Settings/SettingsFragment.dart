import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_project/Providers/ThemeProvider.dart';
import 'package:todo_project/main.dart';
import 'package:todo_project/ui/home/Settings/LanguageBottomSheet.dart';
import 'package:todo_project/ui/home/Settings/ThemeBottomSheet.dart';

class SettingsFragments extends StatefulWidget {
  @override
  _SettingsFragmentsState createState() => _SettingsFragmentsState();
}

class _SettingsFragmentsState extends State<SettingsFragments> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mode',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: themeProvider.isDarkModeEnabled()
                  ? MyThemeData.whiteColor
                  : MyThemeData.blackColor,
            ),
          ),
          InkWell(
            onTap: () {
              showThemeBottomSheet();
            },
            child: Container(
              margin: EdgeInsets.only(top: 18, left: 8),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: MyThemeData.whiteColor,
                border: Border.all(
                  width: 1,
                  color: MyThemeData.primaryColor,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: themeProvider.isDarkModeEnabled()
                        ? Text(
                            'Dark',
                            style: TextStyle(color: MyThemeData.primaryColor),
                          )
                        : Text(
                            'Light',
                            style: TextStyle(color: MyThemeData.primaryColor),
                          ),
                  ),
                  Icon(
                    Icons.arrow_drop_down_sharp,
                    color: MyThemeData.primaryColor,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Text(
            'Language',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: themeProvider.isDarkModeEnabled()
                  ? MyThemeData.whiteColor
                  : MyThemeData.blackColor,
            ),
          ),
          InkWell(
            onTap: () {
              showLanguageBottomSheet();
            },
            child: Container(
              margin: EdgeInsets.only(top: 18, left: 8),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: MyThemeData.whiteColor,
                border: Border.all(
                  width: 1,
                  color: MyThemeData.primaryColor,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'English',
                        style: TextStyle(
                          color: MyThemeData.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        builder: (builder) {
          return ThemeBottomSheet();
        });
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        builder: (builder) {
          return LanguageBottomSheet();
        });
  }
}
