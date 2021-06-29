import 'package:flutter/material.dart';
import 'package:todo_project/main.dart';

class SettingFragmentWithDropDown extends StatefulWidget{
  @override
  _SettingFragmentState createState() => _SettingFragmentState();
}

class _SettingFragmentState extends State<SettingFragmentWithDropDown> {
  String selectedLanguage = 'English';
  List<String> languages = ['English', 'Arabic'];
  String selectedMode = 'Light';
  List<String> Modes = ['Light','Dark'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyThemeData.accentColor,
      body: Container(
        padding: EdgeInsets.all(18),
        margin: EdgeInsets.all(18),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Language',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20 , left: 20 , right: 10),
                child:  DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: MyThemeData.whiteColor,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: MyThemeData.primaryColor,
                      ),
                    ),
                  ),
                    isExpanded: true,
                      iconEnabledColor: MyThemeData.primaryColor,
                      items: languages.map((String val){
                        return DropdownMenuItem<String>(
                          value: val,
                            child: Text(val,
                              style: TextStyle(
                                color: MyThemeData.primaryColor
                              ),
                            )
                        );
                      }).toList(),
                    hint: Text('English',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: MyThemeData.primaryColor,
                      ),
                    ),
                    onChanged: (newValue){
                        setState(() {
                          selectedLanguage = newValue ;
                        });
                    },
                  ),
                ),

              SizedBox(height:30,),
              Text('Mode',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20 , left: 20 , right: 10),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: MyThemeData.whiteColor,
                    focusedBorder: OutlineInputBorder(
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: MyThemeData.primaryColor,
                      ),
                    ),

                  ),
                  isExpanded: true,
                  iconEnabledColor: MyThemeData.primaryColor,
                  items: Modes.map((String val){
                    return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val,
                          style: TextStyle(
                              color: MyThemeData.primaryColor
                          ),
                        )
                    );
                  }).toList(),
                  hint: Text('Light',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: MyThemeData.primaryColor,
                    ),
                  ),
                  onChanged: (newValue){
                    setState(() {
                      selectedLanguage = newValue ;
                    });
                  },
                ),
              ),
            ],
          ),
      ),

    );
  }
}