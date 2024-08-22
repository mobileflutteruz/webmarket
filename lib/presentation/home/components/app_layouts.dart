import 'package:flutter/material.dart';
class AppLayout{
  AppLayout._();
  static getSize(BuildContext context){
    return MediaQuery.of(context).size;
  }
  static getScreenHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }
  static getScreenWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }

  // iPhone 13 mini size in pixels
  static getHeight(double pixels,BuildContext context){
    double x=812/pixels;//800/200=4
    return getScreenHeight(context)/x;//800/4  1600/4=400
  }
  static getWidth(double pixels,BuildContext context){
    double x=375/pixels;//800/200=4
    return getScreenWidth(context)/x;//800/4
  }
}