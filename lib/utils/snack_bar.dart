import 'package:flutter/material.dart';
// Foreign
import 'package:flushbar/flushbar.dart';

class CustomSnackBar {

  Flushbar _customBar;
  
  CustomSnackBar(
    String message,
    {Color color = Colors.red}
  ){
    _customBar = SimpleSnackBar.generateSnackBar(
      message, color: color
    );
  }

  void show(BuildContext context) => _customBar?.show(context);

  void hide() => _customBar?.dismiss();
  
}

class SimpleSnackBar{

  static Flushbar generateSnackBar(
    String message,
    {Color color = Colors.red,
     Duration duration}
  ) => Flushbar(
      message: message,
      backgroundColor: color,
      duration: duration,
    );


  static void showSnackBar(
    BuildContext context,
    String message,
    {Color color = Colors.red,
     int duration = 2}
  ){
    generateSnackBar(
      message,
      color: color,
      duration: Duration(seconds: duration)
    )..show(context);
  }
}
