import 'package:flutter/material.dart';

ButtonStyle getButtonStyle(
    double width, double height, double fontSize, Color color) {
  return ButtonStyle(
    shape: MaterialStateProperty.resolveWith((states) => const StadiumBorder()),
    fixedSize:
        MaterialStateProperty.resolveWith((states) => Size(width, height)),
    backgroundColor: MaterialStateProperty.resolveWith((states) => color),
    textStyle: MaterialStateProperty.resolveWith(
        (states) => TextStyle(fontSize: fontSize)),
  );
}
