
import 'package:flutter/material.dart';

Align getText(String data, double fontSize, Alignment alignment){
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