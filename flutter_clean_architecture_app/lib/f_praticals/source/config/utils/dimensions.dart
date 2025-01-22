import 'package:flearn/f_praticals/main.dart';
import 'package:flutter/material.dart';
import 'package:flearn/f_praticals/source/config/utils/context_utils.dart';

class Dimensions {
  static Size size = MediaQuery.of(NavigationService.navigatorKey.currentContext!).size;

  //h=926.0 w= 428.0  13-pro max
  static double screenHeight = size.height;
  static double screenWidth = size.width;

// Width
  static double width2 = screenWidth / 214;
  static double width3 = screenWidth / 142.66;
  static double width5 = screenWidth / 85.6;

//Height
  static double height2 = screenHeight / 463;
  static double height3 = screenHeight / 308.66;
  static double height5 = screenHeight / 185.2;
}
