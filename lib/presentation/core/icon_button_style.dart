import 'package:flutter/material.dart';

// @param secondaryColor: button's color
// @param button: IconButton
// @return the sixed box with the choosen color and icon button
SizedBox getIconButtonStyle(Color secondaryColor, IconButton button) {
  return SizedBox(
    width: 60,
    height: 60,
    child: Card(
        elevation: 10,
        color: secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35.0),
        ),
        child: button),
  );
}

double getIconSize() {
  return 30;
}
