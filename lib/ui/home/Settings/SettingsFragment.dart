import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_project/Providers/AppConfigProvider.dart';
import 'package:todo_project/main.dart';
import 'package:todo_project/ui/home/Settings/LocaleBottomSheet.dart';
import 'package:todo_project/ui/home/Settings/ThemeBottomSheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsFragments extends StatefulWidget {
  @override
  _SettingsFragmentsState createState() => _SettingsFragmentsState();
}

class _SettingsFragmentsState extends State<SettingsFragments> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppConfigProvider>(context);
    final localeProvider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).language,
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
              showLocaleBottomSheet();
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
                    child: localeProvider.locale == 'en'
                        ? Text(
                            'English',
                            style: TextStyle(color: MyThemeData.primaryColor),
                          )
                        : Text(
                            'العربية',
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
            AppLocalizations.of(context).theme,
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
                            AppLocalizations.of(context).dark,
                            style: TextStyle(color: MyThemeData.primaryColor),
                          )
                        : Text(
                            AppLocalizations.of(context).light,
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

  void showLocaleBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        builder: (builder) {
          return LocaleBottomSheet();
        });
  }
}
