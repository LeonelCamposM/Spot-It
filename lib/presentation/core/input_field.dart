import 'package:flutter/material.dart';

Card getInputField(String inputMessage) {
  Color backgroundColor = const Color.fromARGB(164, 0, 0, 0);
  return Card(
    elevation: 10,
    color: backgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    // ignore: prefer_const_constructors
    child: SizedBox(
      width: 600,
      height: 50,
      // ignore: prefer_const_constructors
      child: SizedBox(
        child: SizedBox(
          width: 600,
          height: 50,
          child: TextField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "  " + inputMessage,
            ),
          ),
        ),
      ),
    ),
  );
}
