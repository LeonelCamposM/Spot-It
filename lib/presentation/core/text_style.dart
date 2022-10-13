import 'package:flutter/material.dart';

// @param data: get the data for the text
// @param fontSize: button's font size
// @param alignment: aligment type
// @return the text with the choosen info, font size and aligment
Align getText(String data, double fontSize, Alignment alignment) {
  return Align(
    alignment: alignment,
    child: Padding(
      padding: const EdgeInsets.all(9.0),
      child: Text(
        data,
        style: TextStyle(fontSize: fontSize),
      ),
    ),
  );
}
