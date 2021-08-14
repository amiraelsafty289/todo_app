import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_project/Providers/AppConfigProvider.dart';
import 'package:todo_project/main.dart';

class LocaleBottomSheet extends StatelessWidget {
  AppConfigProvider localeProvider;
  @override
  Widget build(BuildContext context) {
    localeProvider = Provider.of<AppConfigProvider>(context);
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(15),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              if (localeProvider.locale != 'en') {
                localeProvider.changeLocale('en');
                localeProvider.saveLocalization('en');
                Navigator.pop(context);
              }
            },
            child: getRow('English', localeProvider.locale == 'en'),
          ),
          SizedBox(
            height: 24,
          ),
          InkWell(
            onTap: () {
              if (localeProvider.locale != 'ar') {
                localeProvider.changeLocale('ar');
                localeProvider.saveLocalization('ar');
                Navigator.pop(context);
              }
            },
            child: getRow('العربية', localeProvider.locale == 'ar'),
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
                  color: localeProvider.isDarkModeEnabled()
                      ? MyThemeData.whiteColor
                      : MyThemeData.blackColor),
            ),
          ),
        ],
      );
    }
  }
}
