import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  bool _darkTheme   = false;
  bool _customTheme = false;
  ThemeData _currentTheme;

  ThemeChanger(int theme){
    switch(theme){
      case 1:{
        //light
        this._darkTheme = false;
        this._customTheme = false;
        this._currentTheme = ThemeData.light();
      }break;
      case 2:{
        //dark
        this._customTheme = false;
        this._darkTheme = true;
        this._currentTheme = ThemeData.dark().copyWith(
          accentColor: Colors.pink,
        );
      }break;
      case 3:{
        this._darkTheme = false;
        this._customTheme = true;
      }break;
      default:{
        this._darkTheme = false;
        this._customTheme = false;
        this._currentTheme = ThemeData.light();
      }
    }
  }

  bool get getDarkTheme => this._darkTheme;
  bool get getCustomTheme => this._customTheme;
  ThemeData get getCurrentTheme => this._currentTheme;

  set setDarkTheme(bool dark) {
    this._customTheme = false;
    this._darkTheme = dark;
    if(dark){
      this._currentTheme = ThemeData.dark().copyWith(
        accentColor: Colors.pink,
      );
    }else{
      this._currentTheme = ThemeData.light();
    }
    notifyListeners();
  }

  set setCustomTheme(bool custom) {
    this._darkTheme = false;
    this._customTheme = custom;
    if(custom){
      this._currentTheme = ThemeData.dark().copyWith(
        accentColor: Color(0xff48A0EB),
        primaryColorLight: Colors.white,
        scaffoldBackgroundColor: Color(0xff16202B),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
        ),
        //primaryColor
        //scaffoldBackgroundColor
        //textTheme.bodyText1.color
      );
    }else{

    }
    notifyListeners();
  }

}