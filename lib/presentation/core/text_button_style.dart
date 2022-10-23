import 'package:flutter/material.dart';
import 'package:spot_it_game/presentation/core/text_style.dart';
import 'button_style.dart';

// @param text: button's text
// @param width: size for the button's width
// @param height: size fot the button's height
// @return the sixed box with the choosen size and text for the button
SizedBox getTextButton(String text, double width, double height,
    double fontSize, Color color, Function()? onPressed) {
  return SizedBox(
    height: height,
    width: width,
    child: ElevatedButton(
      style: getButtonStyle(200, 60, 20.0, color),
      onPressed: onPressed,
      child: getText(text, fontSize, Alignment.center),
    ),
  );
}
