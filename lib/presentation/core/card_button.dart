import 'package:flutter/material.dart';

Card getIconButton(IconData icon, Color secondaryColor) {
  return Card(
    elevation: 10,
    color: secondaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(35.0),
    ),
    // ignore: prefer_const_constructors
    child: SizedBox(
      width: 50,
      height: 50,
      child: Icon(
        icon,
        color: const Color.fromARGB(255, 255, 255, 255),
        size: 30,
      ),
    ),
  );
}
