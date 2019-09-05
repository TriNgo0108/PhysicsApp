import 'package:flutter/cupertino.dart';

class ScreenSize{
  static widthScreen(context) => MediaQuery.of(context).size.width;
  static heightScreen(context) => MediaQuery.of(context).size.height;
}