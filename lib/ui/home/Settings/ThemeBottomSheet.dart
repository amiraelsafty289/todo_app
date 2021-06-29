import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_project/Providers/ThemeProvider.dart';
import 'package:todo_project/main.dart';

class ThemeBottomSheet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
           InkWell(
             onTap: (){
               if(themeProvider.isDarkModeEnabled()){
                 themeProvider.toggleTheme();
               }
             },
               child: Padding(
                 padding: EdgeInsets.all( 8),
                   child: getRow('Light', !themeProvider.isDarkModeEnabled()))),
          SizedBox(height: 24,),
          InkWell(
            onTap: (){
              if(!themeProvider.isDarkModeEnabled()){
                themeProvider.toggleTheme();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(  8),
              child: getRow('Dark', themeProvider.isDarkModeEnabled()),
            ),
          ),

        ],
      ),
    );
  }
  Widget getRow(String text , bool isSelected){
    if(isSelected){
      return Row(
        children: [
          Expanded(child: Text(text,
            style: TextStyle(
              color: MyThemeData.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          ),
          Icon(Icons.check, color: MyThemeData.primaryColor,size:24,),
        ],
      );
    }else {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            Expanded(child: Text(text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ),
          ],
        ),
      );

    }
  }
}