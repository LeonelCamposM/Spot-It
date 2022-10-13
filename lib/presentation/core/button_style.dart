import 'package:flutter/material.dart';

// @param width: size for the button's width
// @param height: size fot the button's height
// @param fontSize: button's font size
// @param color: button's color
// @return the button with the choosen style: width, height, fontSize, color
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
