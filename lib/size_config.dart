import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    orientation = _mediaQueryData!.orientation;
  }
}

//get the proportionate height as per screen size

double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight!.toDouble();

  // 812 is the layout height that designer use
  return (inputHeight / 896.0) * screenHeight;
}

//get the proportionate Width as per screen size

double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth!.toDouble();

  // 375 is the layout width that designer use
  return (inputWidth / 414.0) * screenWidth;
}
