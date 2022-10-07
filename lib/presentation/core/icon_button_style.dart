import 'package:flutter/material.dart';

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
