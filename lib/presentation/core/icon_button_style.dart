import 'package:flutter/material.dart';

Card getIconButtonStyle(Color secondaryColor, IconButton button) {
  return Card(
      elevation: 10,
      color: secondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
      ),
      child: button);
}

double getIconSize() {
  return 30;
}
